//
//  NewsTableViewController.swift
//  DimaApp4
//
//  Created by Dzmitry Miklashevich on 1/5/17.
//  Copyright © 2017 Dzmitry Miklashevich. All rights reserved.
//

import UIKit

let kNoItemSelected = -1

class NewsTableViewController: UITableViewController, NewsLoaderDelegate {
    
    var selectedIndex = kNoItemSelected
    var currentNews: [NewsItem]?
    var newsLoader: NewsLoader
    
    required init?(coder aDecoder: NSCoder) {
        
        newsLoader = NewsLoader()
        super.init(coder: aDecoder)
        newsLoader.delegate = self
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
        refreshControl?.addTarget(self, action: #selector(reloadData), for: UIControlEvents.valueChanged)
        
        reloadData()
        newsLoader.loadNews()
    }
    
    func reloadData() {
        
        newsLoader.loadNews()
    }
    
    func refreshUI() {
        
        tableView.reloadData()
        refreshControl?.endRefreshing()
       
    }

    func didLoadNews(news: [NewsItem]) {
        
        currentNews = news
        refreshUI()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let currentNews = currentNews{
            return currentNews.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "NewsTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsTableViewCell else {
            fatalError("The dequeued cell is not an instance of NewsTableViewCell.")
        }
        guard let newsItem = currentNews?[indexPath.row] else {
            fatalError("Cannot retrieve a news item")
        }
        
        cell.setup(with: newsItem)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "detailSegue") {
            if let detailViewController = segue.destination as? DetailViewController {
                detailViewController.newsItem = currentNews?[selectedIndex]
            }
        }
    }
}












