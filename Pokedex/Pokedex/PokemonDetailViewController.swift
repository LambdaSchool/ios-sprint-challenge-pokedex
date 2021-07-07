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
        
        let abilitiesString = pokemon.abilities.map { $0.ability.name }.joined(separator: ", ")
        let typesString = pokemon.types.map { $0.type.name }.joined(separator: ", ")
        
        nameLabel.text = pokemon.name
        idLabel.text = "id: \(pokemon.id)"
        typesLabel.text = "types: \(typesString)"
        abilitiesLabel.text = "abitities: \(abilitiesString)"
        
       
    }

    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    var pokemonController: PokemonController?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
}
