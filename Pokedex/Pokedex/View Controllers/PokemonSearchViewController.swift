//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Welinkton on 9/21/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {

    // attach buttons, action for save button, for searchbar action, update the view for title?, make sure they are on main queue
    //good grief man. :/
    
    var pokemonController = PokemonController()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.setTitle("", for: .normal)
        nameLabel.text = ""
        idLabel.text = ""
        typesLabel.text = ""
        abilitiesLabel.text = ""
        searchBar.delegate = self
    }
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
   
    
    private func updateViews() {
        guard let pokemon = pokemon else {return}
        
        saveButton.setTitle("Save", for: .normal)
        
        nameLabel.text = pokemon.name
        idLabel.text = "id: \(pokemon.id)"
        typesLabel.text = "types: \(type)"
        abilitiesLabel.text = "abilities"
        
        let abilitesString = pokemon.abilities.map {$0.ability.name}
        let typesString = pokemon.types.map {$0.type.name}
    }
    
    func searchBarClick(_searchBar: UISearchBar) {
        guard let pokemon = searchBar.text else {return}
        
        pokemonController.searchPokemon(name: pokemon, completion: {(_) in
            DispatchQueue.main.async {
                self.pokemon = self.pokemonController?.pokemon
            }
    })
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        guard let pokemon = pokemon else {return}
        pokemonController?.savePokemon(pokemon: pokemon)
        
        
        }
    }
}
