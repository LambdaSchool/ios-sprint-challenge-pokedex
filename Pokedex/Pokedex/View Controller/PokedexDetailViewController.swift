//
//  PokedexDetailViewController.swift
//  Pokedex
//
//  Created by Hayden Hastings on 5/17/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import UIKit

class PokedexDetailViewController: UIViewController {

    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name
        IDLabel.text = String(pokemon.id)
        let pokemonTypes: [String] = pokemon.types.map{ $0.type.name}
        typesLabel.text = "\(pokemonTypes.joined(separator: ", "))"
        let pokemonAbilities: [String] = pokemon.abilities.map{ $0.ability.name }
        abilityLabel.text = "\(pokemonAbilities.joined(separator: ", "))"
        
        guard let url = URL(string: pokemon.sprites.frontDefault),
            let image = try? Data(contentsOf: url) else { return }
        pokedexImageView.image = UIImage(data: image)
    }
        
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var pokedexImageView: UIImageView!
   
    @IBOutlet weak var saveButton: UIButton!
    
    
    var pokemon: Pokemon?
    var pokemonControlle: PokemonController?
    var pokemonController = PokemonController()
}
