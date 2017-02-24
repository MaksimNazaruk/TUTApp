//
//  ViewController.swift
//  DimaApp4
//
//  Created by Dzmitry Miklashevich on 12/29/16.
//  Copyright © 2016 Dzmitry Miklashevich. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var galleryContentView: UIView!
    @IBOutlet weak var galleryContentViewWidthConstraint: NSLayoutConstraint!
    
    var newsItem: NewsItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let newsItem = newsItem {
            titleLabel.text = newsItem.title
            bodyLabel.text = newsItem.description
            setupGalleryScrollView()
        }
    }

    func setupGalleryScrollView() {
        if let imageURLs = newsItem?.imageURLs {
            
            var imageViews = [UIImageView]()
            var hConstraintFormat = "H:|"
            var vConstraints = [NSLayoutConstraint]()
            var imageViewsDict = [String : UIImageView]()
            
            let imageWidth: CGFloat = view.frame.size.width - 36
            let imageHight: CGFloat = (imageWidth / 4.0) * 3.0 - 5
            
            for i in 0..<imageURLs.count {
                let imageView = LoadingImageView(frame:CGRect.zero)
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.loadImageFromUrl(urlString: imageURLs[i])
                galleryContentView.addSubview(imageView)
                imageViews.append(imageView)
                let imageViewTitle = "imageView\(i)"
                imageViewsDict[imageViewTitle] = imageView
                hConstraintFormat += "-[\(imageViewTitle)(\(imageWidth))]"
                
                vConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[\(imageViewTitle)(\(imageHight))]-|", options: [], metrics: nil, views: [imageViewTitle : imageView])
            }
            hConstraintFormat += "-|"
            let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: hConstraintFormat, options: [], metrics: nil, views: imageViewsDict)
            
            NSLayoutConstraint.activate(hConstraints)
            NSLayoutConstraint.activate(vConstraints)
        }
    }
    
    @IBAction func showFullArticle(_ sender: AnyObject) {
        if let newsItemLink = newsItem?.link {
            if let url = URL(string: newsItemLink) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let galleryVC = segue.destination as? GalleryViewController {
            galleryVC.imageURLs = newsItem?.imageURLs
        }
    }
    
}





