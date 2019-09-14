//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Aaron on 9/14/19.
//  Copyright © 2019 AlphaGrade, INC. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    var pokemon: Pokemon? {
        didSet {
            updateValues()
        }
    }


    func updateValues() {
        guard let  pokemon = pokemon else {return}
        DispatchQueue.main.async {
            self.pokemonNameLabel.text = pokemon.name
            
        }
        
        
    }

}
