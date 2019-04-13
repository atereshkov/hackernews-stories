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
        
        let scanHTMLOperation = scanService.scanHTML(url: url) { icons in
            //items.append(contentsOf: icons)
        }
        completionBlock.addDependency(scanHTMLOperation)
        scanQueue.addOperation(scanHTMLOperation)
        
        if let host = url.host {
            var url = host + "/favicon.ico"
            if urlStr.contains("https://") {
                url = "https://" + host + "/favicon.ico"
            } else if urlStr.contains("http://") {
                url = "http://" + host + "/favicon.ico"
            }
            let request = RootIconRequest.checkFavicon(url: url)
            let scanFaviconOperation = scanService.scanFavicon(data: request) { icon in
                guard let icon = icon else { return }
                items.append(icon)
            }
            completionBlock.addDependency(scanFaviconOperation)
            scanQueue.addOperation(scanFaviconOperation)
        }
        
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
