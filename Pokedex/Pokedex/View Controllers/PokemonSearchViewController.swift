//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Mitchell Budge on 5/17/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pokemonNameLabel.text = ""
        pokemonIDLabel.text = ""
        pokemonTypeLabel.text = ""
        pokemonAbilityLabel.text = ""
        saveButton.setTitleColor(.white, for: .normal)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilityLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    func updateViews(pokemon: Pokemon?) {
        guard let pokemon = pokemon else { return }
        self.pokemonNameLabel.text = pokemon.name
        pokemonIDLabel.text = String(pokemon.id)
        // include abilities, types, and sprites
        saveButton.setTitleColor(.blue, for: .normal)
    } // end of update views
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchedPokemon = searchBar.text?.lowercased(), searchBar.text != "" else { return }
        pokemonController?.searchPokemon(with: searchedPokemon, completion: { (result) in
            DispatchQueue.main.async {
                self.updateViews(pokemon: self.pokemon)
            }
        })
    } // end of search bar
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let newPokemon = pokemon else { return }
        pokemonController?.addNewPokemon(newPokemon: newPokemon)
        navigationController?.popViewController(animated: true)
    } // end of save button
}
