//
//  Extensions.swift
//  Pokedex
//
//  Created by Simon Elhoej Steinmejer on 10/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

extension UIImageView
{
    func loadImageUrlString(_ urlString: String)
    {
        self.image = nil
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
            
            if let error = error
            {
                NSLog("Error downloading image from url \(error)")
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!)
                {
                    self.image = downloadedImage
                }
            })
        }).resume()
    }
}
