//
//  MainViewModel.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

final class MainViewModel: BaseViewModel<MainRouter>, MainViewModelType {
    
    var inputs: MainViewModelInputsType { return self }
    var ouputs: MainViewModelOutputsType { return self }
    var callbacks: MainViewModelCallbacksType {
        get { return self }
        set { return }
    }
    
    private var items: [StoryType] = []
    private var totalItemsCount: Int = 0
    
    private let storyService: StoryServiceProtocol
    
    override init(session: SessionType) {
        self.storyService = session.resolve()
        super.init(session: session)
    }
    
    var reloadItems: (() -> Void)?
    var showLoading: ((Bool) -> Void)?
    
    var itemsCount: Int {
        return items.count
    }
    
}

private extension MainViewModel {
    
    func setup() {
        
    }
    
}

// MARK: MainViewModelInputsType

extension MainViewModel: MainViewModelInputsType {
    
    func start() {
//        storyService.getItem(id: 19592771) { story, error in
//            guard let story = story else { return }
//            ConsoleLog.i(story)
//        }
        
//        storyService.getBestStories() { stories, error in
//            ConsoleLog.i(stories)
//        }
        
        let configuration = APIConfiguration(.dev, baseURL: "https://hacker-news.firebaseio.com/v0/")
        let executorFactory = RequestExecutorFactory(configuration: configuration)
        let executor = executorFactory.makeNetworkExecutor()
        
        let ids: [Int] = [19592771, 19607169, 19597239]
        
        let completion = BlockOperation { [weak self] in
            Swift.print("Execution of the queue is ended")
            Swift.print("Stories: \(self?.items)")
            self?.totalItemsCount = (self?.items.count ?? 0) + 1
            self?.showLoading?(false)
            self?.reloadItems?()
        }
        
        showLoading?(true)
        for id in ids {
            let request = StoryRequest.getStory(id: id)
            let operation = RequestOperation(executor: executor, request: request) { [weak self] story in
                guard let story = story else { return }
                self?.items.append(story)
            }
            completion.addDependency(operation)
        }
        
        OperationQueue.main.addOperation(completion)
    }
    
    func itemSelected(at index: Int) {
        //guard let item = item(for: index) else { return }
    }
    
    func willDisplayCell(at index: Int) {
        guard items.count < self.totalItemsCount else { return }
        if index >= items.count - 1 {
            //loadMoreItems(offset: items.value.count)
        }
    }
    
    func pullToRefreshAction() {
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
