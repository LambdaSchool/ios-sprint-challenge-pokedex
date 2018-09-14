//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Daniela Parra on 9/14/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    private func updateViews() {
        guard let pokemon = pokemon else { return }
        
        title = pokemon.name
        
        nameLabel.text = pokemon.name
        idLabel.text = String(pokemon.id)
        typesLabel.text = pokemon.types
        abilitiesLabel.text = pokemon.abilities
    }

    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    var pokemonController: PokemonController?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
}
