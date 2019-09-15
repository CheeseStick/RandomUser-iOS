//
//  ImageManager.swift
//  RandomUser
//
//  Created by Jun Jung on 9/15/19.
//  Copyright © 2019 JunJung. All rights reserved.
//

import UIKit

class ImageManager {
    static let shared = ImageManager() // shared instance
    private init() {} // Prevent creation (Thread safe)
    
    private var images : Dictionary<String, UIImage> = Dictionary<String, UIImage>() // image cache
    
    func requestImage(url : URL, onSuccess : @escaping ((UIImage)->Void)) {
        if(self.images[url.absoluteString] != nil) { // check it exists (Cache hit)
            onSuccess(self.images[url.absoluteString]!)
        } else {
            let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in
                if(err == nil) {
                    DispatchQueue.main.async() {
                        self.images[url.absoluteString] = UIImage(data: data!)
                        onSuccess(self.images[url.absoluteString]!)
                    }
                }
            }
            task.resume()
        }
    }
    
    func cleanCache() {
        images.removeAll()
    }
}

