//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Austin Cole on 12/18/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var pokemonSpriteImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    
    
    var pokemon: PokemonModel?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    
    func updateViews() {
        DispatchQueue.main.async {
            guard let pokemon = self.pokemon else {return}
            guard let url = URL(string: (pokemon.sprites.frontDefault)), let imageData = try? Data(contentsOf: url) else {return}
            self.pokemonSpriteImage.image = UIImage(data: imageData)
            self.pokemonNameLabel.text = pokemon.name.capitalized
            self.pokemonIDLabel.text = "ID: \(pokemon.id)"
            let pokemonAbilities = pokemon.abilities.map({$0.ability.name
            }).joined(separator: ", ")
            self.pokemonAbilitiesLabel.text = "Abilities: \(pokemonAbilities)"
            let pokemonTypes = pokemon.types.map({$0.type.name
            }).joined(separator: ", ")
            self.pokemonTypesLabel.text = "Types: \(pokemonTypes)"
        }
    }
}
