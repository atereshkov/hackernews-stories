//
//  MainView.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import UIKit

final class MainView: BaseView<MainViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var tableViewDelegate: MainViewTableViewDelegate?
    private var tableViewDatasource: MainViewTableViewDatasource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        viewModel?.reloadItems = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel?.showLoading = { [weak self] show in
            self?.showLoading(show)
        }
        
        viewModel?.start()
    }
    
}

private extension MainView {
    
    func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonTitle = ""
        navigationItem.title = "Stories"
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.registerNibCell(MainViewCell.self)
        
        guard let viewModel = viewModel else { return }
        tableViewDelegate = MainViewTableViewDelegate(viewModel: viewModel)
        tableViewDatasource = MainViewTableViewDatasource(viewModel: viewModel)
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDatasource
    }
    
    func showLoading(_ show: Bool) {
        tableView.isHidden = show
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
}
