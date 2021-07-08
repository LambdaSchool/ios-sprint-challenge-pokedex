//
//  ImageCellTableViewCell.swift
//  Pokemon
//
//  Created by Yvette Zhukovsky on 10/26/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class ImageCellTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var cellImage: UIImageView!
    
    
    var poke: Pokemon? {
        didSet {
            textLabel?.text = poke?.name
            cellImage.image = poke?.image
        }
    }
    
    
   
}
