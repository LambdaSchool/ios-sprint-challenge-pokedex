//
//  PokedexTableViewCell.swift
//  Pokedex
//
//  Created by Chris Price on 5/16/20.
//  Copyright © 2020 com.chrispriiice. All rights reserved.
//

import UIKit

class PokedexTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    var pokemonController: PokemonController?
    var pokemonImage: UIImage?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        pokemonNameLabel.text = pokemon.name
        guard let pokemonImageData = pokemon.image else { return }
        self.pokemonImageView.image = UIImage(data: pokemonImageData)
        
    }

}
