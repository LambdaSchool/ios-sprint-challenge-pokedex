//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Linh Bouniol on 8/10/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
//    var pokemonController: PokemonController?
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var abilityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    func updateViews() {
        guard let pokemon = pokemon else { return }
      
        self.nameLabel?.text = "Name: \(pokemon.name)"
        self.idLabel?.text = "ID: \(String(pokemon.id))"
        self.abilityLabel?.text = "Abilities: \(pokemon.abilities.joined(separator: ", "))" // join all the strings of the array
        self.typeLabel?.text = "Types: \(pokemon.types.joined(separator: ", "))"
    }
}
