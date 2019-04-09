//
//  MainViewModel.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

final class MainViewModel: BaseViewModel<MainRouter>, MainViewModelType {
    
    private let storyService: StoryServiceProtocol
    
    override init(session: SessionType) {
        self.storyService = session.resolve()
        super.init(session: session)
    }
    
}

private extension MainViewModel {
    
    func setup() {
        
    }
    
}

// MARK: MainViewModelInputsType

extension MainViewModel: MainViewModelInputsType {
    
    func start() {
        storyService.getItem(id: 19592771) { story, error in
            guard let story = story else { return }
            ConsoleLog.i(story)
        }
    }
    
}

// MARK: MainViewModelOutputsType

extension MainViewModel: MainViewModelIOutputsType {
    
}
