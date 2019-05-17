//
//  PokemonTableViewCell.swift
//  PokemonChallenge
//
//  Created by Ryan Murphy on 5/17/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        
        
        guard let pokemon = pokemon else { return }
        guard let imageData = pokemon.imageData else { return }
        
        nameLabel.text = pokemon.name
        pokemonImageView.image = UIImage(data: imageData)
    }
}
