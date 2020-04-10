//
//  PokemonTableViewCell.swift
//  PokeDex
//
//  Created by Nichole Davidson on 4/10/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
   
    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        pokemonNameLabel.text = pokemon.name
    }

}
