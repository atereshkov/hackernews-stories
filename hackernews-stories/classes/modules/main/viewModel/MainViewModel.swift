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
        static let preferredIconType: IconType = .apple
        static let sortOrder: StoryTypeOrder = .score
    }
    
    var inputs: MainViewModelInputsType { return self }
    var outputs: MainViewModelOutputsType { return self }
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
    private let scanManager: ScanManagerProtocol
    
    override init(session: SessionType) {
        self.storyService = session.resolve()
        
        let scanService = ScanService()
        self.scanManager = ScanManager(scanService: scanService)
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
    
    func loadBestStories(limit: Int = Constants.paginationLimit, sortOrder: StoryTypeOrder) {
        showLoading?(true)
        storyService.getBestStoriesIds() { [weak self] stories, error in
            self?.showLoading?(false)
            guard let stories = stories else {
                self?.showLoading?(false)
                return
            }
            self?.storiesIds = stories
            self?.totalItemsCount = stories.count
            let ids = Array(stories.prefix(limit))
            self?.loadItems(ids: ids, sortOrder: sortOrder)
        }
    }
    
    func loadItems(ids: [Int], sortOrder: StoryTypeOrder) {
        guard !isLoadingItemsInProgress else { return }
        isLoadingItemsInProgress = true
        showLoading?(true)
        storyService.getItems(ids: ids) { [weak self] stories, error in
            defer {
                self?.isLoadingItemsInProgress = false
                self?.showLoading?(false)
            }
            let sortedItems = stories.sorted(by: sortOrder)
            self?.items.append(contentsOf: sortedItems)
            self?.reloadItems?()
        }
    }
    
    func startIconScan(indexPath: IndexPath, item: StoryType, preferredIcontType: IconType) {
        guard itemImages[item.id] == nil else { return }
        scanManager.scan(indexPath: indexPath, item: item) { [weak self] icons, indexPath in
            self?.itemImages[item.id] = icons.first(where: { $0.type == preferredIcontType })
            self?.reloadRows?([indexPath], .none)
        }
    }
    
}

// MARK: MainViewModelInputsType

extension MainViewModel: MainViewModelInputsType {
    
    func start() {
        loadBestStories(sortOrder: Constants.sortOrder)
    }
    
    func itemSelected(at index: Int) {
        guard let item = item(for: index), let link = item.url else { return }
        router?.open(link: link)
    }
    
    func willDisplayCell(at index: Int) {
        guard items.count < self.totalItemsCount else { return }
        if index >= items.count - 1 {
            let ids = Array(storiesIds[items.count...Constants.paginationLimit + items.count - 1])
            loadItems(ids: ids, sortOrder: Constants.sortOrder)
        }
    }
    
    func cellForRowCalled(at indexPath: IndexPath) {
        guard let item = item(for: indexPath.row) else { return }
        startIconScan(indexPath: indexPath, item: item, preferredIcontType: Constants.preferredIconType)
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
