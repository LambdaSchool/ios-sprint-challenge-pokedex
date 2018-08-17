//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Lisa Sampson on 8/17/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveButtonWasTapped(_ sender: Any) {
        
    }

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    
}
