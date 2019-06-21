//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Andrew Liao on 8/10/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let pokemon = pokemon else {return}
        
        nameLabel.text = pokemon.name
        idLabel.text = String(pokemon.id)
        typeLabel.text = pokemon.pokeTypes
        abilitiesLabel.text = pokemon.pokeAbilities
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    var pokemon:Pokemon?
    
}
