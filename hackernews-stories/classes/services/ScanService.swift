//
//  ScanService.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/13/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol ScanServiceProtocol {
    func scan(url: URL, completion: @escaping ([IconProtocol]) -> Void) -> Operation
}

final class ScanService: ScanServiceProtocol {
    
    init() {
        
    }
    
    func scan(url: URL, completion: @escaping ([IconProtocol]) -> Void) -> Operation {
        let scanOperation = IconScanOperation(url: url) { [weak self] icons in
            completion(icons)
        }
        return scanOperation
    }
    
}
