//
//  ViewController.swift
//  Pokemom Storyboard
//
//  Created by Alex Rhodes on 9/7/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class RealDetailViewController: UIViewController {
    
    var pokemon: Pokemon?
    
    let ui = UIController()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViews(with: pokemon)
    }
    
    var pokedexController: PokedexController?
    
    func setViews(with pokemon: Pokemon?) {
        
        ui.viewConfiguration(view)
        
        guard let pokemon = pokemon else {return}
        
        pokemonIdLabel.text = String(pokemon.id)
        nameLabel.text = pokemon.name
        
        var types = ""
        let typeArray = pokemon.types
        
        for type in typeArray {
            types.append("\(type.type.name)")
            types.append("\n")
        }
        
        pokemonTypesLabel.text = types
        
        var abilities = ""
        let abilityArray = pokemon.abilities
        
        for ability in abilityArray {
            abilities.append("\(ability.ability.name)")
            abilities.append("\n")
        }
        pokemonAbilitiesLabel.text = abilities
        
        let url = URL(string: pokemon.sprites.frontDefault)!
        if let image = try? Data(contentsOf: url) {
            pokemonImageView.image = UIImage(data: image)
        }
        
        
    }
    
}
