//
//  UImageAndURL.swift
//  PokedexApp
//
//  Created by Lambda_School_Loaner_218 on 12/6/19.
//  Copyright © 2019 Lambda_School_Loaner_218. All rights reserved.
//

import UIKit

// code was found at www.hackingswift.com

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
