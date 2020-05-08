//
//  PokemonTableViewCell.swift
//  PokedexSprint_iOS17
//
//  Created by Stephanie Ballard on 5/8/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    // MARK: - Outlets -
    @IBOutlet weak var pokemonNameTextLabel: UILabel!
    
    // MARK: - Properties -
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        pokemonNameTextLabel.text = pokemon.name
        pokemonNameTextLabel.textColor = .red
    }

}
