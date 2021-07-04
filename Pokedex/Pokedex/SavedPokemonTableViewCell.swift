//
//  SavedPokemonTableViewCell.swift
//  Pokedex
//
//  Created by Julian A. Fordyce on 1/1/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import UIKit

class SavedPokemonTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "cell"
    
    @IBOutlet weak var spriteImageView: UIImageView!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
}
