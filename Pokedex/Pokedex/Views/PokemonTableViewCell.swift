//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Niranjan Kumar on 11/1/19.
//  Copyright © 2019 Nar Kumar. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonName: UILabel!
    
    var pokemon: Pokemon? {
        didSet{
            updateViews()
        }
    }
    
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        
        pokemonName.text = pokemon.name
    
    
    }
    

}
