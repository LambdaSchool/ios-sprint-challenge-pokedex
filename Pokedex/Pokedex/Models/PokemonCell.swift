//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Clean Mac on 5/18/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import Foundation
import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "PokemonCell"

    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
 

    
    //Mark: - PRIVATE
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        
        nameLabel.text = pokemon.name
     
    }
}
