//
//  PokémonDetailViewController.swift
//  Pokédex
//
//  Created by Samantha Gatt on 8/10/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var pokemon: Pokemon?
    var pokemonController: PokemonController?
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedDetails" {
            
            let destVC = segue.destination as! PokemonViewController
            
            guard let thisController = pokemonController,
                let thisPokemon = pokemon else {
                    fatalError("PokemonSearchViewController has no pokemonController and/or pokemon property")
            }
            
            destVC.pokemonController = thisController
            destVC.pokemon = thisPokemon
        }
    }
}
