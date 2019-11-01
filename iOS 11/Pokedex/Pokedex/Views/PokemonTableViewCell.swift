//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by brian vilchez on 11/1/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    var pokemon: Pokemon? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        guard let pokemon = pokemon else {return }
        guard let imagedata = try? Data(contentsOf: pokemon.sprites.frontDefault) else {return}
        pokemonImage.image = UIImage(data: imagedata)
        pokemonNameLabel.text = pokemon.name
    }

}
