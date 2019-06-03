//
//  PokedexTableViewCell.swift
//  Pokedex
//
//  Created by Stephanie Bowles on 6/2/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

class PokedexTableViewCell: UITableViewCell {

    
    @IBOutlet weak var pokeNameLabel: UILabel!
    
    @IBOutlet weak var spriteView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
