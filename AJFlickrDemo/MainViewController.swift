//
//  ViewController.swift
//  AJFlickrDemo
//
//  Created by Leon on 12/23/17.
//  Copyright © 2017 Leon. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var searchBar: UISearchBar?
    
    var flickrDownloader: FlickrPhotoDownloader?
    var photos: [FlickrPhoto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.flickrDownloader = FlickrPhotoDownloader.init()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // IBAction
    
    @IBAction func search(_ sender: Any) {
        print("search text: \(self.searchBar!.text!)")
        let searchText = self.searchBar!.text!
        self.flickrDownloader?.fetchPhotosWithSearchText(searchText: searchText, { (error: NSError?, photos: [FlickrPhoto]?) in
            if error == nil {
                self.photos = photos!
            }
            else {
                self.photos = []
                DispatchQueue.main.async {
                    self.showErrorAlert()
                }
            }
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        })
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let searchResultCellIdentifier = "ThumbnailCell"
        let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: searchResultCellIdentifier, for: indexPath) as? ThumbnailCell
        cell?.backgroundColor = UIColor.white
        cell?.setupCell(flickrPhoto: self.photos[indexPath.row])
        return cell!
    }
    
    // Alert
    func showErrorAlert() {
        let alertController = UIAlertController(title: "Search Error", message: "Invalid API Key", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

