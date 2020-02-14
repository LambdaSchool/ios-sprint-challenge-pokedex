//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by scott harris on 2/14/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        nameLabel.text = pokemon.name
        idLabel.text = "\(pokemon.id)"
        var typesString = ""
        for type in pokemon.types {
            typesString += type.type.name + " "
        }
        typesLabel.text = typesString
        var abilityString = ""
        for ability in pokemon.abilities {
            abilityString += ability.ability.name + " "
        }
        abilitiesLabel.text = abilityString
        
    }
    
    
    
}
