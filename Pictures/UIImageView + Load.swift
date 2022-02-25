//
//  UIImageView + Load.swift
//  Pictures
//
//  Created by Алена on 22.02.2022.
//

import UIKit

// Extension для UIImageView с функцией загрузки фото
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageWithUrl(urlString: String) {
        image = nil

        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            image = cachedImage
            return
        }
        
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                if let unwrappedError = error {
                    print(unwrappedError)
                    return
                }
                
                if let unwrappedData = data, let downloadedImage = UIImage(data: unwrappedData) {
                    DispatchQueue.main.async(execute: {
                        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                        self.image = downloadedImage
                    })
                }
                
            }
            dataTask.resume()
        }
    }
}
