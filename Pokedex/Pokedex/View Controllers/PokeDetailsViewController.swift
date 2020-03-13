//
//  PokeDetailsViewController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_259 on 3/13/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import UIKit

class PokeDetailsViewController: UIViewController {
    
    // MARK: - Properties
    var pokeController: PokeController?
    var pokemon: Pokemon?
    
    
    // MARK: - IBOutlets
    @IBOutlet var pokeImageView: UIImageView!
    @IBOutlet var pokeIDLabel: UILabel!
    @IBOutlet var pokeTypesLabel: UILabel!
    @IBOutlet var pokeAbilitiesLabel: UILabel!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var searchBar: UISearchBar!
    
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
    }
    
    func updateViews() {
        if let pokemon = pokemon {
            title = pokemon.name
            pokeIDLabel.text = "ID: \(pokemon.id)"
            pokeTypesLabel.text = "Types: \(pokemon.types)"
            pokeAbilitiesLabel.text = "Abilities: \(pokemon.abilities)"
            
        }
    }

}

extension PokeDetailsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let pokemon = searchBar.text,
            !pokemon.isEmpty {
            pokeController?.fetchPokemon(pokemon: pokemon) { result in
                if let pokemon = try? result.get() {
                    DispatchQueue.main.async {
                        self.pokeController?.pokemons.append(pokemon)
                        self.updateViews()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.title = "Error"
                    }
                }
            }
            
        }
    }
}
