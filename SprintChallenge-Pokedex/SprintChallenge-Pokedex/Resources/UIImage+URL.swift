//
//  UIImage+URL.swift
//  SprintChallenge-Pokedex
//
//  Created by Ciara Beitel on 9/7/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

//https://www.hackingwithswift.com/example-code/uikit/how-to-load-a-remote-image-url-into-uiimageview

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
