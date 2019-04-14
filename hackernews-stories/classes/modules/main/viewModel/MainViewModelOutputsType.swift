//
//  MainViewModelOutputsType.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewModelOutputsType {
    var itemsCount: Int { get }
    var noImagePlaceholder: UIImage? { get }
    func item(for index: Int) -> StoryType?
    func icon(for index: Int) -> IconProtocol?
}
