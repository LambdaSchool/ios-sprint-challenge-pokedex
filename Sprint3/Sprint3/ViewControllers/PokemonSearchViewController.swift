//
//  PokemonSearchViewController.swift
//  Sprint3
//
//  Created by Kobe McKee on 5/17/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {

    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonTypes: UILabel!
    @IBOutlet weak var pokemonAbilities: UILabel!
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        pokemonName.text = pokemon.name.capitalized
        let id = String(pokemon.id)
        pokemonID.text = "ID: \(id)"
        let type: [String] = pokemon.types.map { $0.type.name }
        pokemonTypes.text = "Type(s): \n\(type.joined(separator: "\n"))"
        let abilities: [String] = pokemon.abilities.map { $0.ability.name }
        pokemonAbilities.text = "Abilities: \n\(abilities.joined(separator: "\n"))"
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        print("Search clicked")
        
        pokemonController?.searchPokemon(with: searchTerm, completion: { (result, error) in
            if error != nil {
                NSLog("Error searching for \(searchTerm): \(error)")
            }
            self.pokemon = result
            DispatchQueue.main.async {
                self.updateViews()
                self.searchBar.text = ""
            }
        })
        
        
    }
    
    @IBAction func savePokemonClicked(_ sender: UIButton) {
        
        guard let pokemon = pokemon else { return }
        pokemonController?.savePokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
        
        
        
    }
    
    



}
