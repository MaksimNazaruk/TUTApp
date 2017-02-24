//
//  File.swift
//  DimaApp4
//
//  Created by Dzmitry Miklashevich on 1/26/17.
//  Copyright © 2017 Dzmitry Miklashevich. All rights reserved.
//

import Foundation
import UIKit

protocol NewsLoaderDelegate {
    
    func didLoadNews(news: [NewsItem])

}

class NewsLoader {
    
    var isLoading = false
    var delegate: NewsLoaderDelegate? = nil
    var newsTableViewCell = NewsTableViewCell()
    
    func loadNews(){
        if isLoading {
            return
        }
        isLoading = true
        let todoEndpoint: String = "http://news.tut.by/rss/index.rss"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let data = data {
                let parser = Parser()
                let newsItems = parser.parseData(data: data)
                self.isLoading = false
                DispatchQueue.main.async {
                    self.delegate?.didLoadNews(news: newsItems)
                }
                
                if let error = error{
                    print("Error:\(error) + Description:\(error.localizedDescription)")
                    return
                }
                
                
            }
        })
        
        task.resume()
    }
    
}



