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
        
        let url = URL(string: "https://www.raywenderlich.com/apple-touch-icon.png")!
        let icon = Icon(url: url, type: .apple)
        DispatchQueue.main.async {
            completion([icon], nil)
        }
    }
    
}
