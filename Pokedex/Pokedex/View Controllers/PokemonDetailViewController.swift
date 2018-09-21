//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Welinkton on 9/21/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemonController = PokemonController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    var pokemon = Pokemon.self {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
   
    
    private func updateViews() {
        guard let pokemon = self.pokemon else {return}
        
         title = pokemon.name
        
        let abilities = pokemon.abilities.map {$0.ability.name}.joined(separator: ",")
        let type = pokemon.types.map {$0.type.name}.joined(separator: ",")
        
        nameLabel.text = pokemon.name
        idLabel.text = "id: \(pokemon.id)"
        typeLabel.text = "types: \(type)"
        abilitiesLabel.text = "abilities: \(abilities)"
    
    }
}
