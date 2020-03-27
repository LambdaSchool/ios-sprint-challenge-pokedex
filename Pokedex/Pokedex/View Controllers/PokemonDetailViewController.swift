//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Elizabeth Thomas on 3/20/20.
//  Copyright © 2020 Libby Thomas. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonIdNumber: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    // MARK: - Properties
    var pokemonController: PokemonController!
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViews()
    }
    
    func updateViews() {
        if let pokemon = pokemon {
            title = pokemon.name
            pokemonNameLabel.text = "\(pokemon.name)"
            pokemonIdNumber.text = "ID: \(String(pokemon.id))"
            pokemonTypeLabel.text = "Types: " + pokemon.types.map({$0.type.name}).joined(separator: ", ")
            pokemonAbilitiesLabel.text = "Abilities: " + pokemon.abilities.map({$0.ability.name}).joined(separator: ", ")
        } else {
            return
        }
    }
}
