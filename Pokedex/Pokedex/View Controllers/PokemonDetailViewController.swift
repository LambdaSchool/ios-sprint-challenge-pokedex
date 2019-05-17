//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Mitchell Budge on 5/17/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    var pokemonController: PokemonController?
    var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let pokemon = pokemon else { return }
        pokemonNameLabel.text = pokemon.name
        pokemonIDLabel.text = String(pokemon.id)
        let pokemonTypes: [String] = pokemon.types.map{$0.type.name}
        pokemonTypeLabel.text = "\(pokemonTypes.joined(separator: ", "))"
        let pokemonAbilities: [String] = pokemon.abilities.map{$0.ability.name}
        pokemonAbilityLabel.text = "\(pokemonAbilities.joined(separator: ", "))"
        guard let url = URL(string: pokemon.sprites.frontDefault), let image = try? Data(contentsOf: url) else { return }
        pokemonImageView.image = UIImage(data: image)
    }
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilityLabel: UILabel!

}
