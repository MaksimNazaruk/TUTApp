//
//  GalleryViewController.swift
//  TUTBYApp
//
//  Created by Maksim Nazaruk on 2/13/17.
//  Copyright © 2017 Dzmitry Miklashevich. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageURLs:[String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

// Collection view data source / delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell else {
            fatalError("Can't load gallery cell")
        }
        
        if let imageURL = imageURLs?[indexPath.row] {
            cell.imageView.loadImageFromUrl(urlString: imageURL)
        }
        
        return cell
    }    
}
