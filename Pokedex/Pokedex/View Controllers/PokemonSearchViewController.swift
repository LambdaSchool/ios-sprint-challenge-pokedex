//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Lisa Sampson on 5/10/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Properties and Outlets
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
    }
}
