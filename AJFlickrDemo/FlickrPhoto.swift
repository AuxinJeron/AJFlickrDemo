//
//  FlickrPhoto.swift
//  AJFlickrDemo
//
//  Created by Leon on 12/26/17.
//  Copyright © 2017 Leon. All rights reserved.
//

import Foundation

class FlickrPhoto: NSObject {
    let id: String
    let title: String
    let owner: String
    let farm: Int
    let server: String
    let secret: String
    
    public init(id: String, title: String, owner: String, farm: Int, server: String, secret: String) {
        self.id = id
        self.title = title
        self.owner = owner
        self.farm = farm
        self.server = server
        self.secret = secret
    }
    
    internal var photoUrl: NSURL {
        return NSURL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
    }
}
