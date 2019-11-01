//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Niranjan Kumar on 11/1/19.
//  Copyright © 2019 Nar Kumar. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()

    }
    
    
    
    private func updateViews() {
        if let pokemon = pokemon {
         //    fetch image here
            pokemonController?.getImage(at: pokemon.sprites.front_default, completion: { (result) in
                if let image = try? result.get() {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            })
            self.navigationItem.title = pokemon.name.capitalized
            pokemonNameLabel.text = pokemon.name.capitalized
            idLabel.text  = "ID: \(pokemon.id)"
            typesLabel.text = "Type: \(pokemon.types.compactMap({ $0.type.name}))"
            abilitiesLabel.text = "Abilities: \(pokemon.abilities.compactMap({$0.ability.name}))"
        } else {
            self.title = "Pokemon Search"
        }
    }
    

    @IBAction func saveTapped(_ sender: Any) {
        guard let searchedPokemon = pokemon else { return }
//        guard let pokemonController = pokemonController else { return }
        
//        let newPokemon = Pokemon(name: searchedPokemon.name, id: searchedPokemon.id, abilities: searchedPokemon.abilities, types: searchedPokemon.types, sprites: searchedPokemon.sprites)
        pokemonController?.savedPokemon.append(searchedPokemon)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
}





extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonController = pokemonController else { return }
        guard let searchTerm = searchBar.text?.lowercased(), !searchTerm.isEmpty else { return }
        

        pokemonController.getPokemon(named: searchTerm) { (result) in
                let pokemon = try? result.get()
                DispatchQueue.main.async {
                self.pokemon = pokemon
                self.updateViews()

                }
            }
        }
}
