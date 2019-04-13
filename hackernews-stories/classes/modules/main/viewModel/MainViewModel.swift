//
//  MainViewModel.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation
import UIKit

final class MainViewModel: BaseViewModel<MainRouter>, MainViewModelType {
    
    private struct Constants {
        static let paginationLimit: Int = 20
    }
    
    var inputs: MainViewModelInputsType { return self }
    var ouputs: MainViewModelOutputsType { return self }
    var callbacks: MainViewModelCallbacksType {
        get { return self }
        set { return }
    }
    
    private var itemImages: [Int: IconProtocol?] = [:]
    private var items: [StoryType] = []
    private var storiesIds: [Int] = []
    private var totalItemsCount: Int = 0
    private var isLoadingItemsInProgress: Bool = false
    
    private let storyService: StoryServiceProtocol
    private let scanService: ScanServiceProtocol
    
    let pendingOperations = PendingOperations()
    
    override init(session: SessionType) {
        self.storyService = session.resolve()
        self.scanService = session.resolve()
        super.init(session: session)
    }
    
    var itemsCount: Int {
        return items.count
    }
    
    // MARK: MainViewModelCallbacksType
    
    var reloadItems: (() -> Void)?
    var showLoading: ((Bool) -> Void)?
    var reloadRows: (([IndexPath], UITableView.RowAnimation) -> Void)?
    
}

private extension MainViewModel {
    
    func loadBestStories() {
        showLoading?(true)
        storyService.getBestStoriesIds() { [weak self] stories, error in
            self?.showLoading?(false)
            guard let stories = stories else {
                self?.showLoading?(false)
                return
            }
            self?.storiesIds = stories
            self?.totalItemsCount = stories.count
            let ids = Array(stories.prefix(Constants.paginationLimit))
            self?.loadItems(ids: ids)
        }
    }
    
    func loadItems(ids: [Int]) {
        guard !isLoadingItemsInProgress else { return }
        isLoadingItemsInProgress = true
        showLoading?(true)
        storyService.getItems(ids: ids) { [weak self] stories, error in
            defer {
                self?.isLoadingItemsInProgress = false
                self?.showLoading?(false)
            }
            let sortedItems = stories.sorted { $0.score ?? 0 > $1.score ?? 0 }
            self?.items.append(contentsOf: sortedItems)
            self?.reloadItems?()
        }
    }
    
    func startDownload(indexPath: IndexPath) {
        //Swift.print("Start download for: \(indexPath.row)")
        guard pendingOperations.downloadsInProgress[indexPath] == nil else {
            return
        }
        
        guard let item = item(for: indexPath.row), let urlStr = item.url else { return }
        guard itemImages[item.id] == nil else { return }
        Swift.print("Start download item \(indexPath.row) : \(item.title)")

        let scaner = ImageScaner(url: URL(string: "https://google.com/")!) { [weak self] icon in
            Swift.print("Ended download for \(indexPath.row) and \(item.title)")
            self?.itemImages[item.id] = icon
            self?.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
            self?.reloadRows?([indexPath], .none)
        }

        pendingOperations.downloadsInProgress[indexPath] = scaner
        pendingOperations.downloadQueue.addOperation(scaner)
    }
    
}

// MARK: MainViewModelInputsType
extension MainViewModel: MainViewModelInputsType {
    
    func start() {
        loadBestStories()
    }
    
    func itemSelected(at index: Int) {
        guard let item = item(for: index), let link = item.url else { return }
        router?.open(link: link)
    }
    
    func willDisplayCell(at index: Int) {
        guard items.count < self.totalItemsCount else { return }
        if index >= items.count - 1 {
            let ids = Array(storiesIds[items.count...Constants.paginationLimit + items.count - 1])
            loadItems(ids: ids)
        }
    }
    
    func willDisplayCell(at indexPath: IndexPath) {
        //startDownload(indexPath: indexPath)
    }
    
    func cellForRowCalled(at indexPath: IndexPath) {
        startDownload(indexPath: indexPath)
    }
    
    func pullToRefreshAction() {
        items.removeAll()
        start()
    }
    
}

// MARK: MainViewModelOutputsType

extension MainViewModel: MainViewModelOutputsType {
    
    func item(for index: Int) -> StoryType? {
        guard index >= 0 && index < items.count else { return nil }
        return items[index]
    }
    
    func icon(for index: Int) -> IconProtocol? {
        guard index >= 0 && index < items.count else { return nil }
        guard let item = item(for: index) else { return nil }
        let itemImage = itemImages.first(where: { $0.key == item.id })?.value
        return itemImage
    }
    
}

class PendingOperations {
    lazy var downloadsInProgress: [IndexPath: Operation] = [:]
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}
