//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Kat Milton on 6/21/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var pokemonSprite: UIImageView!


    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        DispatchQueue.main.async {
            self.pokemonNameLabel.text = pokemon.name
            let imageName = pokemon.sprites.front_default
            let imageURL = URL(string: imageName)
            let imageData = try! Data(contentsOf: imageURL!)
            self.pokemonSprite.image = UIImage(data: imageData)
        }
    }

}
