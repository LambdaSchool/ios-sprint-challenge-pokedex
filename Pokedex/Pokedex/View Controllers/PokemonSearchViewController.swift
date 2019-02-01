//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Paul Yi on 2/1/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchResultsUpdating {
    var pokemon: Pokemon?
    var pokemonController: PokemonController?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search Pokemon"
        navigationItem.searchController = search
        definesPresentationContext = true
    }
    
    func updateViews() {
        if let pokemon = pokemonController?.pokemon {
            title = pokemon.name
            nameLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
            typeLabel.text = pokemon.types.first?.type.name
            abilitiesLabel.text = pokemon.abilities.first?.ability.name
        } else {
            title = "Pokemon Search"
            nameLabel.text = ""
            idLabel.text = ""
            typeLabel.text = ""
            abilitiesLabel.text = ""
        }
    }
    
    @IBAction func savePokemon(_ sender: Any) {
        guard let pokemon = pokemonController!.pokemon else { return }
        pokemonController?.create(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        pokemonController?.fetch(searchName: text, completion: { (error) in
            if let error = error {
                NSLog("Error fetching: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.updateViews()
            }
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
