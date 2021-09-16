//
//  HomeViewController.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 13/09/21.
//

import UIKit

//MARK:- News List View
class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    var viewModel: HomeViewModelType = HomeViewModel(manager: HomeManager())
    private var isShowLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.attach(view: self)
        
        addRefreshControl()
        setupTableView()
    }
    
    func bind() {
        viewModel.reloadData = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.isLoading = { [weak self] isLoading in
            isLoading ? self?.startAnimating() : self?.stopAnimating()
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        
        tableView.register(UINib(nibName: NewsCell.identifier, bundle: nil), forCellReuseIdentifier: NewsCell.identifier)
    }
    
    func addRefreshControl() {
        refreshControl.tintColor = .white
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshNewsData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshNewsData(_ sender: Any) {
        // Refresh News Data
        viewModel.fetchNewData(isNew: true)
        self.refreshControl.endRefreshing()
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        cell.thumbnailImageView.image = nil
        cell.data = viewModel.newsList[indexPath.row]
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellSelected(index: indexPath.row)
    }
    
    //MARK:- Fetch New Data Pagination on Last cell Diaplay of Table
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoadingIndexPath(indexPath) else { return }
        fetchNextPage()
    }
    
    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard !isShowLoading else { return false }
        return viewModel.newsList.isEmpty || indexPath.row == viewModel.newsList.count - 1
    }
    
    private func fetchNextPage() {
        viewModel.fetchNewData(isNew: false)
        isShowLoading = true
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color =  .white
        spinner.frame = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 70)
        spinner.startAnimating()
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
    }
    
    func updateFooter() {
        isShowLoading = false
        tableView.tableFooterView = UIView()
    }
    
}

extension HomeViewController: HomeViewType {
    
    //MARK:- Navigate to News Details Screen
    func navigateToNewDetailsPage(news: News) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
        
        viewController.viewModel.selectedNews = news
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true)
    }
}
