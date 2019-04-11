//
//  MainViewModel.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

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
    
    private var items: [StoryType] = []
    private var storiesIds: [Int] = []
    private var totalItemsCount: Int = 0
    private var isLoadingItemsInProgress: Bool = false
    
    private let storyService: StoryServiceProtocol
    private let scanService: ScanServiceProtocol
    
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
    
    func scan(items: [StoryType]) {
        let url = URL(string: "https://www.raywenderlich.com/")!
        scanService.scan(url: url) { [weak self] icons, error in
            Swift.print()
        }
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
    
}
