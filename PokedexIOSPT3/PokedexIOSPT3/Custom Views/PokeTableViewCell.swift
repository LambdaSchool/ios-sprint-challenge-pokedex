//
//  PokeTableViewCell.swift
//  PokedexIOSPT3
//
//  Created by Jessie Ann Griffin on 11/10/19.
//  Copyright © 2019 Jessie Griffin. All rights reserved.
//

import UIKit

class PokeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var spriteImageView: UIImageView!
    
    var pokemonController: PokemonController?
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        
        titleLabel.text = pokemon.name
        
        pokemonController?.fetchImage(from: "\(pokemon.sprites.front_default)") { result in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.spriteImageView.image = image
                }
            }
        }
    }
}
