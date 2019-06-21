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
        nameLabel.text = ""
        idLabel.text = ""
        typeLabel.text = ""
        abilitiesLabel.text = ""
        saveOutlet.setTitle("", for: .normal)
        searchBar.delegate = self        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm  = searchBar.text else {return}
        pokemonController?.fetch(searchName: searchTerm, completion: { (pokemon, error) in
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
                self.abilitiesLabel.text = "Abilities: \(abilities)"
                self.pokemon = pokemon
                self.saveOutlet.setTitle("Save Pokemon", for: .normal)
            }
        })
    }
    @IBAction func savePokemon(_ sender: Any) {

        guard let pokemon = pokemon else {return}
        pokemonController?.create(newPokemon: pokemon)
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    //MARK: - Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
   
    @IBOutlet weak var saveOutlet: UIButton!
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
}
