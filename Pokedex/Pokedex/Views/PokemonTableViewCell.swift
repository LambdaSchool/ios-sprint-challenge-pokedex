//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Bohdan Tkachenko on 5/18/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var spriteImageView: UIImageView!
    
    var pokemonAPI: PokemonAPI? {
        didSet {
            updateViews()
        }
    }
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let pokemon = pokemon else {return}
        nameLabel.text = pokemon.name.capitalizingFirstLetter()
        
        self.pokemonAPI?.fetchImage(at: pokemon.sprites, completion: { (result) in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.spriteImageView.image = image
                }
            }
        })
    }
    
    
    
}
