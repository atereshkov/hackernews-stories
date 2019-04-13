//
//  IconScanOperation.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/13/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

class IconScanOperation: AsyncOperation {
    
    private weak var task: URLSessionTask?
    
    init(url: URL, completion: @escaping ([IconProtocol]) -> Void) {
        super.init()
        
        task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            defer { self?.finish() }
            // TODO
            let url = URL(string: "https://www.raywenderlich.com/apple-touch-icon.png")!
            let icon = Icon(url: url, type: .favicon)
            let url2 = URL(string: "https://freeiconshop.com/wp-content/uploads/edd/bulb-curvy-flat.png")!
            let icon2 = Icon(url: url2, type: .apple)
            completion([icon, icon2])
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
