//
//  PokeDetailViewController.swift
//  Pokedex
//
//  Created by Alexander Supe on 12/8/19.
//  Copyright © 2019 Alexander Supe. All rights reserved.
//

import UIKit

class PokeDetailViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    //Attributes
    var pokemon: Pokemon? { didSet{ updateViews() } }
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard isViewLoaded,
            let pokemon = pokemon else { return }
        if pokemon.name != nameLabel.text {
            guard let pokeImg = try? Data(contentsOf: pokemon.sprites.frontDefault) else { return }
            nameLabel.text = pokemon.name.capitalized
            pokeImage.image = UIImage(data: pokeImg)
            idLabel.text = "ID: \(pokemon.id)"
            
            // Type
            var typeText = "Type: "
            for type in pokemon.types {
                if type != pokemon.types[0] {
                    typeText.append(", ")
                }
                typeText.append(type.type.name.capitalized)
            }
            typesLabel.text = typeText
            
            // Abilities
            var abilityText = "Abilities: "
            for ability in pokemon.abilities {
                if ability != pokemon.abilities[0] {
                    abilityText.append(", ")
                }
                abilityText.append(ability.ability.name.capitalized)
            }
            abilitiesLabel.text = abilityText
        }
    }
}
