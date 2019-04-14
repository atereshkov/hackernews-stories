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
    @IBOutlet weak var noInternetView: UIView!
    
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
        viewModel?.callbacks.reloadRows = { [weak self] indexPaths, animation in
            DispatchQueue.main.async { [weak self] in
                self?.reloadRows(at: indexPaths, animation)
            }
        }
        viewModel?.callbacks.updateState = { [weak self] state in
            DispatchQueue.main.async { [weak self] in
                self?.handle(state)
            }
        }
        
        viewModel?.inputs.start()
    }
    
}

private extension MainView {
    
    func setupView() {
        navigationItem.backBarButtonTitle = ""
        navigationItem.title = "main.nav-title".localized
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
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            pullToRefreshControl.endRefreshing()
        }
    }
    
    func handle(_ state: MainViewState) {
        switch state {
        case .noInternet:
            showNoInternetConnectionAlert()
        }
    }
    
    func reloadRows(at indexPaths: [IndexPath], _ animation: UITableView.RowAnimation) {
        if animation == .none {
            UIView.performWithoutAnimation {
                //let contentOffset = tableView.contentOffset
                tableView.reloadRows(at: indexPaths, with: animation)
                //tableView.contentOffset = contentOffset
            }
        } else {
            tableView.reloadRows(at: indexPaths, with: animation)
        }
    }
    
    @objc private func handlePullToRefresh(_ sender: Any) {
        viewModel?.inputs.pullToRefreshAction()
    }
    
}
