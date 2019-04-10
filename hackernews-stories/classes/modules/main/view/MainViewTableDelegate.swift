//
//  MainViewTableDelegate.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/9/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import UIKit

class MainViewTableViewDelegate: NSObject {
    
    private var viewModel: MainViewModelType?
    
    init(viewModel: MainViewModelType) {
        self.viewModel = viewModel
    }
    
}

extension MainViewTableViewDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel?.inputs.itemSelected(at: indexPath.row)
    }
    
}
