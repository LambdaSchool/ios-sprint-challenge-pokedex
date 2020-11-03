//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Thomas Cacciatore on 5/24/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    private func updateViews() {
        guard let pokemon = pokemon else { return }
        DispatchQueue.main.async {
            self.cellLabel.text = pokemon.name.capitalizingFirstLetter()
            let imageString = pokemon.sprites.frontDefault
            let imageURL = URL(string: imageString)
            let imageData =  try! Data(contentsOf: imageURL!)
            let pokemonImage = UIImage(data: imageData)
            self.cellImage.image = pokemonImage
        }
    }
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
}

