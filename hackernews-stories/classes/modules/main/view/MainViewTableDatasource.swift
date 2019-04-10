//
//  MainViewTableDatasource.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/9/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import UIKit

class MainViewTableViewDatasource: NSObject {
    
    private var viewModel: MainViewModelType?
    
    init(viewModel: MainViewModelType) {
        self.viewModel = viewModel
    }
    
}

extension MainViewTableViewDatasource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MainViewCell = tableView.dequeueReusableCell(for: indexPath) else { return UITableViewCell() }
        guard let item = viewModel?.item(for: indexPath.row) else { return UITableViewCell() }
        cell.update(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.ouputs.itemsCount ?? 0
    }
    
}
