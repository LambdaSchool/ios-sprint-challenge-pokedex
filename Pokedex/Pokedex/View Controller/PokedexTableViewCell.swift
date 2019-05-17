//
//  PokedexTableViewCell.swift
//  Pokedex
//
//  Created by Hayden Hastings on 5/17/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import UIKit

class PokedexTableViewCell: UITableViewCell {

    private func updateViews() {
        guard let pokemon = pokemon else { return }
        
        pokedexLabel.text = pokemon.name
       
    }

    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var pokedexImageView: UIImageView!
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
}
