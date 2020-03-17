//
//  PokemonTableViewCell.swift
//  FlexPokemonSprint
//
//  Created by admin on 10/4/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon? {
        didSet {
            setViews()
        }
    }
    
    func setViews() {
        guard let pokemon = pokemon else { return }
        
        nameLabel.text = pokemon.name
    }
  

}
