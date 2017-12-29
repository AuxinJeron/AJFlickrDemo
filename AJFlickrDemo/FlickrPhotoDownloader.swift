//
//  FlickrPhotoDownloader.swift
//  AJFlickrDemo
//
//  Created by Leon on 12/26/17.
//  Copyright © 2017 Leon. All rights reserved.
//

import Foundation
import AFNetworking

typealias flickerDownloadCompletion = (NSError?, [FlickrPhoto]?) -> Void

class FlickrPhotoDownloader: NSObject {
    struct Keys {
        static let flickrKey = "3027fe3b0adcad28e4255b02c06e7f83"
    }
    
    var sessionManager: AFURLSessionManager?
    
    public override init() {
        sessionManager = AFURLSessionManager.init(sessionConfiguration: URLSessionConfiguration.default)
    }
    
    func fetchPhotosWithSearchText(searchText: String, _ completion: @escaping flickerDownloadCompletion) {
        let escapedSearchText = searchText.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlHostAllowed)
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Keys.flickrKey)&tags=\(escapedSearchText!)&per_page=25&format=json&nojsoncallback=1"
        let url = URL(string: urlString)!
        let request = URLRequest.init(url: url)
        
        let task = sessionManager?.dataTask(with: request, completionHandler: { (urlResponse, responseObj, error) in
            if (error != nil) {
                print("Error fetching photos:\(error!)")
                completion(error as NSError?, nil)
                return
            }
            guard let result = (responseObj as? NSDictionary)?["photos"] as? NSDictionary else {return}
            guard let photos = result["photo"] as? [NSDictionary] else {return}
            let flickrPhotos: [FlickrPhoto] = photos.map({ (photoDictionary: NSDictionary) -> FlickrPhoto in
                let id = photoDictionary["id"] as? String ?? ""
                let title = photoDictionary["title"] as? String ?? ""
                let owner = photoDictionary["owner"] as? String ?? ""
                let farm = photoDictionary["farm"] as? Int ?? 0
                let server = photoDictionary["server"] as? String ?? ""
                let secret = photoDictionary["secret"] as? String ?? ""
                let flickrPhoto = FlickrPhoto(id: id, title: title, owner: owner, farm: farm, server: server, secret: secret)
                return flickrPhoto
            })
            completion(nil, flickrPhotos)
        })
        
        task?.resume()
    }
}
