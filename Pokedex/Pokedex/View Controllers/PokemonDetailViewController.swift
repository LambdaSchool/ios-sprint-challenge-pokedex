//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Welinkton on 9/21/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemonController: PokemonController?
    
    var pokemon = Pokemon? {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateViews() {
        guard let pokemon = pokemon else {return}
        
        title = pokemon.name
        
        nameLabel.text = pokemon.name
        idLabel.text = "id: \(pokemon.id)"
        typesLabel.text = "types: \(type)"
        abilitiesLabel.text = "abilities"
        
        let abilities = pokemon.abilities.map {$0.ability.name}
        let type = pokemon.types.map {$0.type.name}
        
    }
    

}
