//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Bohdan Tkachenko on 5/16/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var pokemonImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
