//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Andrew Liao on 8/10/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm  = searchBar.text else {return}
        pokemonController?.fetch(searchName: searchTerm, completion: { (pokemon, error) in
            if let error = error {
                NSLog("Error fetching: \(error)")
            }
            DispatchQueue.main.async {
                self.nameLabel.text = pokemon.name
                self.idLabel.text = pokemon.id
                self.pokemon = pokemon
            }
        })
    }
    @IBAction func savePokemon(_ sender: Any) {

        guard let pokemon = pokemon else {return}
        pokemonController?.create(newPokemon: pokemon)
        
    }
    
    
    
    //MARK: - Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
}
