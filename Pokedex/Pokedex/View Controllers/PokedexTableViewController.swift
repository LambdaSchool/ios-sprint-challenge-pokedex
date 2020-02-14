//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by scott harris on 2/14/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSearchViewControllerSegue" {
            if let searchVC = segue.destination as? SearchViewController {
                searchVC.pokemonController = pokemonController
            }
            
        }
    }
    
}
