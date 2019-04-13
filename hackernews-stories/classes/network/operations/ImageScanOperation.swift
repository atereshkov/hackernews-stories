//
//  ImageScanOperation.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/13/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

class ImageScanOperation: AsyncOperation {
    
    private weak var task: URLSessionTask?
    
    init(url: URL, completion: @escaping (IconProtocol?) -> Void) {
        super.init()
        
        task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            defer { self?.finish() }
            // TODO
            let url = URL(string: "https://www.raywenderlich.com/apple-touch-icon.png")!
            let icon = Icon(url: url, type: .apple)
            completion(icon)
        }
    }
    
    override func cancel() {
        task?.cancel()
        super.cancel()
    }
    
    override func main() {
        task?.resume()
    }
    
}
