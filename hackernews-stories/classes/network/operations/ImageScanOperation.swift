//
//  IconScanOperation.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/13/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

class IconHTMLScanOperation: AsyncOperation {
    
    private weak var task: URLSessionTask?
    
    init(url: URL, completion: @escaping ([IconProtocol]) -> Void) {
        super.init()
        
        task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            defer { self?.finish() }
            guard let data = data else {
                completion([])
                return
            }
            guard let html = String(data: data, encoding: .utf8) else {
                completion([])
                return
            }
            
            let parser = HTMLIconURLParser(html: html)
            let icons = parser.parse(baseURL: url)
            
            completion(icons)
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
