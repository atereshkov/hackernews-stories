//
//  MainViewModelCallbacks.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/10/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewModelCallbacksType {
    var reloadItems: (() -> Void)? { get set }
    var reloadRows: ((_ paths: [IndexPath], _ animation: UITableView.RowAnimation) -> Void)? { get set }
    var showLoading: ((_ show: Bool) -> Void)? { get set }
}
