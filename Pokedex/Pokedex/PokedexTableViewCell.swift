//
//  PokedexTableViewCell.swift
//  Pokedex
//
//  Created by Josh Kocsis on 5/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit

class PokedexTableViewCell: UITableViewCell {
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        
        pokemonNameLabel.text = pokemon.name
    }

}
