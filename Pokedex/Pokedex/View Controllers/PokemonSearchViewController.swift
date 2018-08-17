//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Lisa Sampson on 8/17/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = ""
        idLabel.text = ""
        typeLabel.text = ""
        abilityLabel.text = ""
        
        searchBar.delegate = self

    }
    
    @IBAction func saveButtonWasTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController?.create(newPokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
    }

    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    
}
