//
//  ImageCache.swift
//  iOS Exam
//
//  Created by Gireesh on 17/07/21.
//

import UIKit

class ImageCache{
    static let shared = ImageCache()
    var cache = NSCache<AnyObject, UIImage>()
    
    func saveImage(image:UIImage,forUrl:AnyObject){
        cache.setObject(image, forKey: forUrl)
    }
    func getImage(url:AnyObject) -> UIImage? {
        return cache.object(forKey: url)
    }
}
