//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Moses Robinson on 1/25/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    private func updateViews() {
        guard let pokemon = pokemon,
            let imageData = pokemon.imageData else { return }
        
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        
        let typeString = pokemon.types.map {$0.type.name.capitalized}.joined(separator: "/")
        typeLabel.text = "Types: \(typeString)"
        
        let abilityString = pokemon.abilities.map {$0.ability.name.capitalized}.joined(separator: ", ")
        abilityLabel.text = "Abilities: \(abilityString)"
        
        imageView.image = UIImage(data: imageData)
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
