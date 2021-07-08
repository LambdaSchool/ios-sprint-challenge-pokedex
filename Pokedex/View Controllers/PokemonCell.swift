//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Jerrick Warren on 12/31/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {
    static let reuseIdentifier = "PokemonCell"
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonSprite: UIImageView!

}
