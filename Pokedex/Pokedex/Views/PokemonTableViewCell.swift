//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Matthew Martindale on 3/22/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name
        idLabel.text = String(pokemon.id)
        getPokemonImage()
    }
    
    func getPokemonImage() {
        guard let pokemonSprite = pokemon?.sprites.frontDefault else { return }
        if let url = URL(string: pokemonSprite) {
            do {
                let data = try Data(contentsOf: url)
                self.pokemonImage.image = UIImage(data: data)
            } catch let err {
                print("Error loading sprite image: \(err.localizedDescription)")
            }
        }
    }
}
