//
//  ScanManager.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/13/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol ScanManagerProtocol {
    func scan(indexPath: IndexPath, item: StoryType, completion: @escaping ([IconProtocol], IndexPath) -> Void)
}

final class ScanManager: ScanManagerProtocol {
    
    private let scanService: ScanServiceProtocol
    private var itemImages: [Int: [IconProtocol]] = [:]
    
    lazy var scanInProgress: [IndexPath: Operation] = [:]
    lazy var scanQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "ImageScanQueue"
        //queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    init(scanService: ScanServiceProtocol) {
        self.scanService = scanService
    }
    
    func scan(indexPath: IndexPath, item: StoryType, completion: @escaping ([IconProtocol], IndexPath) -> Void) {
        guard scanInProgress[indexPath] == nil else { return }
        guard itemImages[item.id] == nil else { return }
        guard let urlStr = item.url, let url = URL(string: urlStr) else { return }
        
        let scanOperation = scanService.scan(url: url) { [weak self] icons in
            self?.itemImages[item.id] = icons
            self?.scanInProgress.removeValue(forKey: indexPath)
            completion(icons, indexPath)
        }
        
        scanInProgress[indexPath] = scanOperation
        scanQueue.addOperation(scanOperation)
    }
    
}
