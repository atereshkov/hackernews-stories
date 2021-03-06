//
//  MainViewModelType.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol MainViewModelType: ViewModelType, MainViewModelInputsType, MainViewModelOutputsType, MainViewModelCallbacksType {
    var inputs: MainViewModelInputsType { get }
    var outputs: MainViewModelOutputsType { get }
    var callbacks: MainViewModelCallbacksType { get set }
}
