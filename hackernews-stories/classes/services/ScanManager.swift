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
    
    private struct Constants {
        static let faviconName = "favicon.ico"
    }
    
    // MARK: Properties
    
    private let scanService: ScanServiceProtocol
    private var itemImages: [Int: [IconProtocol]] = [:]
    
    private(set) lazy var scanInProgress: [IndexPath: Operation] = [:]
    private(set) lazy var scanQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "ImageScanQueue"
        //queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    // MARK: Init
    
    init(scanService: ScanServiceProtocol) {
        self.scanService = scanService
    }
    
    // MARK: API
    
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
            items.append(contentsOf: icons)
        }
        completionBlock.addDependency(scanHTMLOperation)
        scanQueue.addOperation(scanHTMLOperation)
        
        if let host = url.host {
            let url = (url.scheme ?? "http://") + "://" + host + "/" + Constants.faviconName
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
    }
    
}
