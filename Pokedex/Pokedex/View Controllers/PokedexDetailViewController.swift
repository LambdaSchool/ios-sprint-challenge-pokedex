//
//  PokedexDetailViewController.swift
//  Pokedex
//
//  Created by Joshua Rutkowski on 1/26/20.
//  Copyright © 2020 Josh Rutkowski. All rights reserved.
//

import UIKit

class PokedexDetailViewController: UIViewController, UISearchBarDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Properties
    var pokedexController: PokedexController?
    var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
    
// MARK: - IBActions
    @IBAction func saveButtonPressed(_ sender: Any) {
        
    }
}
