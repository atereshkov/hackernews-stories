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
    func cancel(indexPath: IndexPath, item: StoryType)
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
        var items: [IconProtocol] = []
        
        guard scanInProgress[indexPath] == nil else { return }
        guard itemImages[item.id] == nil else { return }
        guard let urlStr = item.url, let url = URL(string: urlStr) else { return }
        
        let completionBlock = BlockOperation { [weak self] in
            DispatchQueue.main.async {
                self?.itemImages[item.id] = items
                self?.scanInProgress.removeValue(forKey: indexPath)
                completion(items, indexPath)
            }
        }
        
        let scanOperation = scanService.scanHTML(url: url) { icons in
            items.append(contentsOf: icons)
        }
        completionBlock.addDependency(scanOperation)
        scanQueue.addOperation(scanOperation)
        
        let scanOperation2 = scanService.scanHTML(url: url) { icons in
            items.append(contentsOf: icons)
        }
        completionBlock.addDependency(scanOperation2)
        scanQueue.addOperation(scanOperation2)
        
        scanInProgress[indexPath] = completionBlock
        OperationQueue.main.addOperation(completionBlock)
    }
    
    func cancel(indexPath: IndexPath, item: StoryType) {
        guard scanInProgress[indexPath] != nil else { return }
        scanInProgress[indexPath]?.cancel()
        scanInProgress[indexPath] = nil
        //Swift.print("Cancel image scan: \(indexPath.row), title: \(item.title ?? "")")
    }
    
}
