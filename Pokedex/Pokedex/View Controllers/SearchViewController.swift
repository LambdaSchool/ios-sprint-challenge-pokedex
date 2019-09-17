//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Jessie Ann Griffin on 9/15/19.
//  Copyright © 2019 Jessie Griffin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    var delegate: UpdatePokedex?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if let pokemon = pokemon {
            delegate?.savePokemonToPokedex(pokemon: pokemon)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
        
        pokemonController?.searchForPokemon(with: searchTerm) { result in
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews(with: pokemon)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func updateViews(with pokemon: Pokemon) {
        pokemonController?.fetchImage(from: "\(pokemon.sprites.front_default)") { result in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        
        var types: String = ""
        for typeObject in pokemon.types {
            types += "\(typeObject.type.name), "
        }
        typeLabel.text = "Types: \(types)"
        
        var abilities: String = ""
        for abilityObject in pokemon.abilities {
            abilities += "\(abilityObject.ability.name), "
        }
        abilitiesLabel.text = "Abilities: \(abilities)"
        
    }
}
