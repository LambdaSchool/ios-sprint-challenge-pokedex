//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Ngozi Ojukwu on 8/17/18.
//  Copyright © 2018 iyin. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = ""
        idLabel.text = ""
        typeLabel.text = ""
        ability.text = ""
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm  = searchBar.text else {return}
        pokemonController?.fetchPokemon(searchName: searchTerm, completion: { (pokemon, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.nameLabel.text = "Pokemon not found"
                }
                NSLog("Error searching: \(error)")
            }
            guard let pokemon = pokemon else {return}
            
            DispatchQueue.main.async {
                guard let types = pokemon.pokeTypes,
                    let abilities = pokemon.pokeAbilities else {return}
                self.nameLabel.text = pokemon.name
                self.idLabel.text = "ID: \(pokemon.id)"
                self.typeLabel.text = "Type(s): \(types)"
                self.ability.text = "Abilities: \(abilities)"
                self.pokemon = pokemon
         
            }
        })
    }
    

    @IBAction func Save(_ sender: Any) {
        guard let pokemon = pokemon else {return}
        pokemonController?.create(newPokemon: pokemon)
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var ability: UILabel!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?

}
