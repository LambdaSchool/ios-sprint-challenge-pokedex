//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Paul Yi on 2/1/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    var pokemon: Pokemon?
    var pokemonController: PokemonController?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let pokemon = pokemon else { return }
        
        title = pokemon.name.capitalized
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        typeLabel.text = "Types: \(pokemon.typesString)"
        abilitiesLabel.text = "Abilities: \(pokemon.abilityString)"
        if let imageData = pokemon.imageData {
            pokemonImageView.image = UIImage(data: imageData)
        } else {
            pokemonImageView.isHidden = true
        }
    }

}
