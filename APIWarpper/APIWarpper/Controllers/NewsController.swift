//
//  ViewController.swift
//  APIWarpper
//
//  Created by Talish George on 17/01/21.
//

import UIKit

class NewsController: UITableViewController, Floatable {
    
    private(set) var categories: [Category] = []
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register Tableview header
        tableView.initHeaderview()
        tableView.tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0.0, height: .leastNormalMagnitude)))
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "NewsHeaderView")
        
        //Register Footer View
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "NewsFooterView")
        
        //Register Tableview cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NewsCell")
        
        //Nav titile
        navigationItem.title = "Latest News"
        
        // Service call to fetch latest news
        fetchNews(by: ApiConstants.newsCategory)
        viewModel.change.bind { [weak self] changes in
            guard let changes = changes, changes.hasChanges else {
                return
            }
            print(changes.hasChanges)
            self?.tableView.reloadData()
        }
    }
}

extension NewsController {
    
    /// Fetch News
    /// - Parameter category: String
    func fetchNews(by category: String) {
        let closureSelf = self
        NewsServices().getNews(category: category) { result in
            var categories = [Category]()
            switch result {
            case Result.success(let response):
                let category = Category(title: "General", articles: response.articles)
                categories.append(category)
                closureSelf.categories = categories
                DispatchQueue.main.async {
                    self.viewModel.newsResponse = response
                    //self.tableView.reloadData()
                }
            case Result.failure(let error):
                DispatchQueue.main.async {
                    //TODO : Error handling
                }
            }
        }
    }
}

//Table view data source
extension NewsController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = viewModel.sections[indexPath.section].rows[indexPath.row]
        
        switch row.category {
        case .general(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
            cell.textLabel?.text = model.title
            return cell
        }
    }
}

//Table view delegate

extension NewsController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch viewModel.sections[section].category {
        case .articles(let model):
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "NewsHeaderView")
            headerView?.textLabel?.text = model.title
            return headerView
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if case .articles = viewModel.sections[indexPath.section].category {
            //Present details Page
        }
    }
}

extension UITableView {
    
    func initHeaderview(_ backgorundColor: UIColor? = nil) {
        let streachAreaView = UIView()
        streachAreaView.translatesAutoresizingMaskIntoConstraints = false
        streachAreaView.backgroundColor = backgroundColor ?? tableHeaderView?.backgroundColor ?? UIColor.blue
        insertSubview(streachAreaView, at: 0)
        
        NSLayoutConstraint.activate([
            streachAreaView.topAnchor.constraint(equalTo: frameLayoutGuide.topAnchor).with(priority: .defaultHigh),
            streachAreaView.widthAnchor.constraint(equalTo: widthAnchor),
            streachAreaView.bottomAnchor.constraint(equalTo: topAnchor)
        ])
    }
}

