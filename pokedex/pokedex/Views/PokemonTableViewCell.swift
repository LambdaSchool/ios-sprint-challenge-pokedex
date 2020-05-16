//
//  PokemonTableViewCell.swift
//  pokedex
//
//  Created by Rob Vance on 5/15/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    // Mark: IBOutlets
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
