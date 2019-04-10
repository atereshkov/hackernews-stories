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
    private let pullToRefreshControl = UIRefreshControl()
    
    private var tableViewDelegate: MainViewTableViewDelegate?
    private var tableViewDatasource: MainViewTableViewDatasource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        viewModel?.callbacks.reloadItems = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        viewModel?.callbacks.showLoading = { [weak self] show in
            DispatchQueue.main.async { [weak self] in
                self?.showLoading(show)
            }
        }
        
        viewModel?.inputs.start()
    }
    
}

private extension MainView {
    
    func setupView() {
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonTitle = ""
        navigationItem.title = "Stories"
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.registerNibCell(MainViewCell.self)
        
        tableView.refreshControl = pullToRefreshControl
        pullToRefreshControl.addTarget(self, action: #selector(handlePullToRefresh(_:)), for: .valueChanged)
        
        guard let viewModel = viewModel else { return }
        tableViewDelegate = MainViewTableViewDelegate(viewModel: viewModel)
        tableViewDatasource = MainViewTableViewDatasource(viewModel: viewModel)
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDatasource
    }
    
    func showLoading(_ show: Bool) {
        //tableView.isHidden = show
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            pullToRefreshControl.endRefreshing()
        }
    }
    
    @objc private func handlePullToRefresh(_ sender: Any) {
        viewModel?.inputs.pullToRefreshAction()
    }
    
}
