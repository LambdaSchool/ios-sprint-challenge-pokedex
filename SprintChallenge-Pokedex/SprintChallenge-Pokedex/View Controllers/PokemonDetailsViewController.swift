//
//  PokemonDetailsViewController.swift
//  SprintChallenge-Pokedex
//
//  Created by Ciara Beitel on 9/6/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    var pokemon: Pokemon?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        nameLabel.text = pokemon.name.capitalized
        guard let url = URL(string: pokemon.sprites.front_shiny) else { return }
        image.load(url: url)
        idLabel.text = "\(pokemon.id)"
        var typesString = ""
        for type in pokemon.types {
            typesString += type.type.name + ", "
        }
        typesLabel.text = typesString
        var abilitiesString = ""
        for ability in pokemon.abilities {
            abilitiesString += ability.ability.name + ", "
        }
        abilitiesLabel.text = abilitiesString
    }
}
