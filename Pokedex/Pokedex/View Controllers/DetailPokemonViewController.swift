//
//  DetailPokemonViewController.swift
//  Pokedex
//
//  Created by Dahna on 5/8/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import UIKit

class DetailPokemonViewController: UIViewController {
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    // MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
    func updateViews() {
        guard let pokemon = pokemon else {
            print("no pokemon")
            return
        }
        self.title = pokemon.name.capitalized
        
        guard let urlPath = pokemon.sprites["front_default"],
            let spriteURL = urlPath else { return }
        
        spriteImageView.loadSprite(url: spriteURL)
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        
        var typesIndex = 0
        var abilitiesIndex = 0
        
        var abilities = pokemon.abilities.count > 1 ? "Abilities: " : "Ability "
        while abilitiesIndex < pokemon.abilities.count {
            if abilitiesIndex > 0 {
                abilities.append(contentsOf: ", ")
            }
            
            guard let ability = pokemon.abilities[abilitiesIndex].ability else { return }
            var capitalizedName: String = ""
            capitalizedName.append(contentsOf: ability.name!.prefix(1).uppercased())
            capitalizedName.append(contentsOf: ability.name!.dropFirst())
            abilities.append(contentsOf: capitalizedName)
            abilitiesIndex += 1
        }
        
        var pokeType = pokemon.types.count > 1 ? "Types: " : "Type: "
        while typesIndex < pokemon.types.count {
            if typesIndex > 0 {
                pokeType.append(contentsOf: ", ")
            }
            
            guard let types = pokemon.types[typesIndex].type else { return }
            var capitalizedName: String = ""
            capitalizedName.append(contentsOf: types.name!.prefix(1).uppercased())
            capitalizedName.append(contentsOf: types.name!.dropFirst())
            pokeType.append(contentsOf: capitalizedName)
            typesIndex += 1
        }
        
        typesLabel.text = pokeType
        abilitiesLabel.text = abilities
        
    }
}

