//
//  PokemonTableViewCell.swift
//  PokeDex
//
//  Created by David Williams on 5/17/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonName: UILabel!
    var pokemon: Pokemon?

    func updateViews() {
        guard let pokemon = pokemon else {return }
        pokemonName.text = pokemon.name
    }

}
