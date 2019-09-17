//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Jessie Ann Griffin on 9/16/19.
//  Copyright © 2019 Jessie Griffin. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        
        cellTitle.text = pokemon.name
        
//        pokemonController?.fetchImage(from: "\(pokemon.sprites.front_default)") { result in
//            if let image = try? result.get() {
//                DispatchQueue.main.async {
//                    self.cellImageView.image = image
//                }
//            }
//        }
    }
}
