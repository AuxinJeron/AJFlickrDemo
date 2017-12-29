//
//  ThumbnailCell.swift
//  AJFlickrDemo
//
//  Created by Leon on 12/25/17.
//  Copyright © 2017 Leon. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ThumbnailCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func setupCell(flickrPhoto: FlickrPhoto) {
        imageView.sd_setImage(with: flickrPhoto.photoUrl as URL!)
    }
}

