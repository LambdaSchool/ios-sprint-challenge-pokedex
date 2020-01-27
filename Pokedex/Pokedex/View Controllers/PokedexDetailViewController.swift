//
//  PokedexDetailViewController.swift
//  Pokedex
//
//  Created by Joshua Rutkowski on 1/26/20.
//  Copyright © 2020 Josh Rutkowski. All rights reserved.
//

import UIKit

class PokedexDetailViewController: UIViewController, UISearchBarDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Properties
    var pokedexController: PokedexController?
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        toggleSearchItems()
        updateViews()
    }
    
    private func updateViews() {
        pokemonDetails()
        guard let pokemon = pokemon else { return }
        
        if let data = pokemon.image {
            let image = UIImage(data: data)
            pokemonImageView.image = image
        } else {
            pokedexController?.fetchImage(for: pokemon, completion: { result in
                if let image = try? result.get() {
                    DispatchQueue.main.async {
                        self.pokemonImageView.image = image
                    }
                } else {
                    print(result)
                }
            })
        }
        
        pokemonNameLabel.text = pokemon.name.capitalized
        pokemonIDLabel.text = "ID: \(pokemon.id)"
        var types = pokemon.types.compactMap { $0.type.name.capitalized }
        
        _ = types.compactMap {
            if let index = types.firstIndex(of: $0) {
                types[index] = $0 }
        }
        
        pokemonTypesLabel.text = "Types: \(types.joined(separator: ", "))"
        
        
        var abilities = pokemon.abilities.compactMap { $0.ability.name.capitalized }
        _ = abilities.compactMap {
            if let index = abilities.firstIndex(of: $0) {
                abilities[index] = $0 }
        }
        pokemonAbilitiesLabel.text = "Abilities: \(abilities.joined(separator: ", "))"
    }
    
    // Searchbar Function
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
        pokedexController?.fetchPokemon(named: searchTerm, completion: { result in
            let pokemon = try? result.get()
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.updateViews()
            }
        })
    }
    
    private func toggleSearchItems() {
        if pokemon != nil {
            navigationItem.title = pokemon?.name.capitalized ?? ""
            searchBar.isHidden = true
            saveButton.isHidden = true
        }
    }
    
    private func pokemonDetails() {
        if pokemon != nil {
            pokemonImageView.isHidden = false
            pokemonNameLabel.isHidden = false
            pokemonIDLabel.isHidden = false
            pokemonTypesLabel.isHidden = false
            pokemonAbilitiesLabel.isHidden = false
        } else {
            pokemonImageView.isHidden = true
            pokemonNameLabel.isHidden = true
            pokemonIDLabel.isHidden = true
            pokemonTypesLabel.isHidden = true
            pokemonAbilitiesLabel.isHidden = true
        }
    }
    
    // MARK: - IBActions
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let addedPokemon = pokemon else { return }
        pokedexController?.pokemons.append(addedPokemon)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
}
