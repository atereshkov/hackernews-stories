//
//  ScanService.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/13/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol ScanServiceProtocol {
    
}

final class ScanService: ScanServiceProtocol {
    
    lazy var scanInProgress: [IndexPath: Operation] = [:]
    lazy var scanQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "ImageScanQueue"
        //queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    init() {
        
    }
    
}
