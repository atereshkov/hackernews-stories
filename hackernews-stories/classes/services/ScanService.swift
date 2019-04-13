//
//  ScanService.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/13/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol ScanServiceProtocol {
    func scanHTML(url: URL, completion: @escaping ([IconProtocol]) -> Void) -> Operation
    func scanFavicon(data: RequestData, completion: @escaping (IconProtocol?) -> Void) -> Operation
}

final class ScanService: ScanServiceProtocol {
    
    init() {
        
    }
    
    /// Parse the page HTML and scan `<head>` section for meta information
    func scanHTML(url: URL, completion: @escaping ([IconProtocol]) -> Void) -> Operation {
        let scanOperation = IconHTMLScanOperation(url: url) { icons in
            completion(icons)
        }
        return scanOperation
    }
    
    /// Check whether `/favicon.ico` exists
    func scanFavicon(data: RequestData, completion: @escaping (IconProtocol?) -> Void) -> Operation {
        let rootFaviconOperation = ScanRootFaviconOperation(data: data) { icon in
            completion(icon)
        }
        return rootFaviconOperation
    }
    
}
