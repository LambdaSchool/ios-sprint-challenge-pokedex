//
//  Helpers.swift
//  Pokédex
//
//  Created by Jason Modisett on 9/14/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import Foundation
import UIKit

// Reuse identifiers
enum ReuseIdentifiers: String {
    case savedPokemon = "SavedPokemonCell"
}

enum SegueIdentifiers: String {
    case search = "ToSearch"
    case details = "ToDetails"
}

// HTTP method enum
enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

// Personal UILabel extension to increase kerning on labels
extension UILabel {
    
    func kern(_ value: CGFloat) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}

// Search bar extension for text color
extension UISearchBar {
    
    func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
}

// Image download/cache class
class ImageCacheManager {
    
    // Types
    static let imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        
        cache.name = "ImageCacheManager"
        
        // Max 100 images in memory
        cache.countLimit = 100
        
        // Max 200 MB used
        cache.totalCostLimit = 200 * 1024 * 1024
        
        return cache
    }()
    
    // Image caching methods
    func cachedImage(url: URL) -> UIImage? {
        return ImageCacheManager.imageCache.object(forKey: url.absoluteString as NSString)
    }
    
    func fetchImage(url: URL, completion: @escaping ((UIImage?) -> Void)) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200, let data = data else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                
                return
            }
            
            if let image = UIImage(data: data) {
                ImageCacheManager.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(UIImage())
                }
            }
        }
        
        task.resume()
    }
    
}
