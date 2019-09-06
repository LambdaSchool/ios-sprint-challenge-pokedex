//
//  PokemonDetailViewController.swift
//  SprintChallenge-Pokedex
//
//  Created by Ciara Beitel on 9/6/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        nameLabel.text = pokemon.name
        // ⚠️ FIX THIS LATER - image ⚠️
        idLabel.text = "\(pokemon.id)"
        var typesString = ""
        for type in pokemon.types {
            typesString += type.type.name
        }
        typesLabel.text = typesString
        var abilitiesString = ""
        for ability in pokemon.abilities {
            abilitiesString += ability.ability.name
        }
        abilitiesLabel.text = abilitiesString
    }
}

