//
//  NewsTableViewCell.swift
//  DimaApp4
//
//  Created by Dzmitry Miklashevich on 1/5/17.
//  Copyright © 2017 Dzmitry Miklashevich. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsImage: LoadingImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM, HH:mm"
        return dateFormatter
    } ()
    
    public func setup(with newsItem: NewsItem) {
        
        titleLabel.text = newsItem.title ?? ""
        
        if let pubDate = newsItem.pubDate {
            dateLabel.text = NewsTableViewCell.dateFormatter.string(from: pubDate as Date)
        } else {
            dateLabel.text = "-"
        }
        
        if let count = newsItem.imageURLs?.count {
            if count > 1 {
                titleLabel.textColor = UIColor.red
            } else {
                titleLabel.textColor = UIColor.black
            }
        }
        
        if let imageURL = newsItem.previewImageURL {
            newsImage.loadImageFromUrl(urlString: imageURL)
        } else {
            newsImage.cancelLoading()
        }
    }

}
