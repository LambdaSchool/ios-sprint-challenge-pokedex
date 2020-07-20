//
//  MainPageViewController.swift
//  Pokedex
//
//  Created by Eoin Lavery on 20/07/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemonShowSegue" {
            if let destinationVC = segue.destination as? PokemonTableViewController {
                destinationVC.title = "Search Pokemon"
                destinationVC.pokedexType = .search
            }
        } else if segue.identifier == "SavedPokemonShowSegue" {
            if let destinationVC = segue.destination as? PokemonTableViewController {
                destinationVC.title = "Saved Pokemon"
                destinationVC.pokedexType = .saved
            }
        }
    }

}
