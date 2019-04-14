//
//  UIImageView.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/11/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    private static var taskKey = 0
    private static var urlKey = 0
    
    private var currentTask: URLSessionTask? {
        get { return objc_getAssociatedObject(self, &UIImageView.taskKey) as? URLSessionTask }
        set { objc_setAssociatedObject(self, &UIImageView.taskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private var currentURL: URL? {
        get { return objc_getAssociatedObject(self, &UIImageView.urlKey) as? URL }
        set { objc_setAssociatedObject(self, &UIImageView.urlKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    // MARK: Public API
    
    /// Asynchronously loads image from the specified URL
    func loadImage(with urlString: String, errorImage: UIImage? = nil) {
        weak var oldTask = currentTask
        currentTask = nil
        oldTask?.cancel()

        self.image = nil
        
        if let cachedImage = ImageCacheService.shared.image(forKey: urlString) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        currentURL = url
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            self?.currentTask = nil
            
            if let error = error {
                ConsoleLog.e(error)
            }
            
            guard let data = data, let downloadedImage = UIImage(data: data) else {
                ConsoleLog.e("Image downloaded, but error occured during extracting")
                DispatchQueue.main.async {
                    self?.image = errorImage
                }
                return
            }
            
            ImageCacheService.shared.save(image: downloadedImage, forKey: urlString)
            
            if url == self?.currentURL {
                DispatchQueue.main.async {
                    self?.image = downloadedImage
                }
            }
        }
        
        currentTask = task
        task.resume()
    }
    
}
