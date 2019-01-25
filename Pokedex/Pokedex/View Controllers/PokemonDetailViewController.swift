//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Moses Robinson on 1/25/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        typeLabel.text = "Types: \(pokemon.types.map {$0.type.name.capitalized}.joined(separator: "/"))"
        abilityLabel.text = "Abilities: \(pokemon.abilities.map {$0.ability.name.capitalized}.joined(separator: ", "))"
    
        pokemonController?.fetchImage(for: pokemon, completion: { (data) in
            guard let data = data else { return }
            let image = UIImage(data: data)
            self.imageView.image = image
        })
    }

    // MARK: - Properties

    var pokemon: Pokemon?
    var pokemonController: PokemonController?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
}
