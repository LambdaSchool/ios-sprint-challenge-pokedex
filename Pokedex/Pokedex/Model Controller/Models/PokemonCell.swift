//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Nonye on 5/10/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {

    @IBOutlet weak var pokemonLabelName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
