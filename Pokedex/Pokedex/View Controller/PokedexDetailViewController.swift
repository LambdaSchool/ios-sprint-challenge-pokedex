//
//  PokedexDetailViewController.swift
//  Pokedex
//
//  Created by Ngozi Ojukwu on 8/17/18.
//  Copyright © 2018 iyin. All rights reserved.
//

import UIKit

class PokedexDetailViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }

   
    func updateViews(){
        
        guard let pokemon = pokemon else {return}
        
        nameLabel.text = pokemon.name
        idLabel.text = String(pokemon.id)
        typesLabel.text = pokemon.pokeTypes
        abilityLabel.text = pokemon.pokeAbilities
    }
  
    var pokemonController: PokemonController?
    var pokemon:Pokemon?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
}
