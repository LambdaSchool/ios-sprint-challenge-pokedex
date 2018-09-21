//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Ilgar Ilyasov on 9/21/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    // MARK: - Outlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Update function
    
    private func updateViews() {
        
        if isViewLoaded {
            
            if let pokemon = pokemon {
                title = pokemon.name
                nameLabel.text = pokemon.name
                idLabel.text = "ID: " + String(pokemon.id)
//                typeLabel.text = "Types: " + String(pokemon.types)
//                abilityLabel.text = "Abilities: " + String(pokemon.abilities)
            } else {
                title = ""
                nameLabel.text = ""
                idLabel.text = ""
                typeLabel.text = ""
                abilityLabel.text = ""
            }
        }
    }
}
