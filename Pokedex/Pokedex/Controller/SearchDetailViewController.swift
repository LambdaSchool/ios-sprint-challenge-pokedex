//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Sameera Leola on 12/14/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController, UISearchBarDelegate {
    
    let reuseIdentifier = "PokemonCell"
    var pokemon: Pokemon?
    var searchResult: SearchResult?
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonSearchBar.delegate = self
        
        //Show the Pokemon
        updateViews()
    }

    @IBAction func savePokemon(_ sender: Any) {
        pokemon?.name = searchResult?.name
        pokemon?.id = (searchResult?.id)!
        updateViews()
    }
    
    
    func updateViews() {
        // Make sure we found a Pokemon
        guard let pokemon = pokemon else { return }
        
        // Show the Pokemon we found
        pokemonNameLabel.text = pokemon.name
        idLabel.text = String(pokemon.id)
        
    }
    
    
    // MARK: - Search for Pokemon
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        pokemonSearchBar.autocapitalizationType = .none
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text?.lowercased(), !searchTerm.isEmpty else { return }
        
        searchBar.text = ""
        searchBar.placeholder = searchTerm
        
        SearchController.shared.performSearch(with: searchTerm) { (error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.updateViews()
                }
            }
        }
        

    } // End of search bar functionality
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} //End of class
