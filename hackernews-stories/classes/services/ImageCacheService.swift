//
//  ImageCacheService.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/11/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation
import UIKit

class ImageCacheService {
    
    static let shared = ImageCacheService()
    
    private let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol?
    
    // MARK: Init
    
    private init() {
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: nil) { [weak self] notification in
            self?.didRecieveMemoryWarning()
        }
    }
    
    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
            self.observer = nil
        }
    }
    
    // MARK: Public
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    // MARK: Private
    
    private func didRecieveMemoryWarning() {
        cache.removeAllObjects()
    }
    
}
