//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Rob Vance on 5/15/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // Mark: IBOutlets
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    // Properties
    var pokemonAPIController: PokemonAPIController?
    var pokemon: Pokemon?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        pokemonSearchBar.becomeFirstResponder()
    }
    
    
    // Mark: IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonAPIController?.savePokemon(pokemon: pokemon)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func updateViews() {
        if let pokemon = pokemon {
            pokemonNameLabel.text = pokemon.name
            var abilitiesText = ""
            for ability in pokemon.abilities {
                abilitiesText += "\(ability.ability.name)"
            }
            pokemonAbilitiesLabel.text = "Abilities: \(abilitiesText)"
            
            var typesText = ""
            for type in pokemon.types {
                typesText += "\(type.type.name)"
            }
            pokemonTypesLabel.text = typesText
            pokemonIdLabel.text = "ID#: \(pokemon.id)"
            
            do {
                guard let url = URL(string: pokemon.sprites.frontDefault) else { return }
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                pokemonImageView.image = image
            } catch {
                print(error)
            }
        }
    }
    
}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        pokemonAPIController?.fetchPokemon(searchTerm: searchBarText) { results in
            switch results {
            case .success(let pokemon):
                print(pokemon)
                self.pokemon = pokemon
                
                
                DispatchQueue.main.async {
                    self.updateViews()
                }
            case .failure(let error):
                print("Error fetching pokemon: \(error)")
            }
        }
    }
}
