//
//  LoadingImageView.swift
//  DimaApp4
//
//  Created by Dzmitry Miklashevich on 1/30/17.
//  Copyright © 2017 Dzmitry Miklashevich. All rights reserved.
//

import Foundation
import UIKit

class LoadingImageView: UIImageView {
 
    private var spinner: UIActivityIndicatorView!
    private var loadingTask: URLSessionDataTask?
    private var session: URLSession?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLoadingImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLoadingImageView()
    }
    
    func setupLoadingImageView() {
        session = URLSession(configuration: .default)
        setupActivityIndicator()
    }
    
    func setupActivityIndicator() {
        if spinner != nil {
            return
        }
        
        spinner = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spinner)
        let viewSpinner = ["spinner": spinner]
        var spinnerConstrains = [NSLayoutConstraint]()
        let spinnerVerticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|[spinner]|", options: [], metrics: nil, views: viewSpinner)
        spinnerConstrains += spinnerVerticalConstraint
        let spinnerHorizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "|[spinner]|", options: [], metrics: nil, views: viewSpinner)
        spinnerConstrains += spinnerHorizontalConstraint
        NSLayoutConstraint.activate(spinnerConstrains)
    }
    
    public func loadImageFromUrl(urlString: String) {
        cancelLoading()
        spinner.startAnimating()
        self.image = nil
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            loadingTask = session?.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                        self.spinner.stopAnimating()
                    }
                }
            })
            loadingTask?.resume()
        }
    }
    
    public func cancelLoading() {
        loadingTask?.cancel()
        spinner.stopAnimating()
        image = nil
    }
}


   
