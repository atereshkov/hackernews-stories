//
//  ScanService.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/11/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol ScanServiceProtocol {
    func scan(url: URL, completion: @escaping ([IconProtocol], Error?) -> Void)
}

final class ScanService: ScanServiceProtocol {
    
    func scan(url: URL, completion: @escaping ([IconProtocol], Error?) -> Void) {
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else {
//                completion([], nil) // TODO
//                return
//            }
//            let html = String(data: data, encoding: .utf8)
//            Swift.print(html)
//        }
//        task.resume()
        
        Swift.print(url.absoluteString)
        
        if url.absoluteString.contains("www") {
            let url = URL(string: "https://www.raywenderlich.com/apple-touch-icon.png")!
            let icon = Icon(url: url, type: .apple)
            DispatchQueue.main.async {
                completion([icon], nil)
                return
            }
        }
        
        if url.absoluteString.contains(".uk") {
            let url = URL(string: "https://cdn4.iconfinder.com/data/icons/new-google-logo-2015/400/new-google-favicon-512.png")!
            let icon = Icon(url: url, type: .favicon)
            DispatchQueue.main.async {
                completion([icon], nil)
                return
            }
        }
        
        if url.absoluteString.contains(".com") {
            let url = URL(string: "http://realfavicongenerator.net/blog/wp-content/uploads/2015/10/demo_favicon.png")!
            let icon = Icon(url: url, type: .favicon)
            DispatchQueue.main.async {
                completion([icon], nil)
                return
            }
        }
        
        if url.absoluteString.contains(".org") {
            let url = URL(string: "https://andrewlock.net/content/images/2016/10/icon.png")!
            let icon = Icon(url: url, type: .favicon)
            DispatchQueue.main.async {
                completion([icon], nil)
                return
            }
        }
        
//        let url = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSl4yxL94THfwv2Khy501SzeeDv82YyCAf3P1oMaqNDNJuxGJZ")!
//        let icon = Icon(url: url, type: .favicon)
//        DispatchQueue.main.async {
//            completion([icon], nil)
//            return
//        }
    }
    
}
