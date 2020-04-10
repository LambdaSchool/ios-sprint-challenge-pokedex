//
//  AddPokemon.swift
//  Pokedex
//
//  Created by Shawn James on 4/10/20.
//  Copyright © 2020 Shawn James. All rights reserved.
//

import UIKit

class AddPokemon: UIViewController {
    
    // MARK: - Selected user pokemon
    
    var selectedUserPokemon: Pokemon?
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var idTextView: UITextView!
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var abilitiesTextView: UITextView!
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: - Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
    }
    
    // MARK: - Add button action
    
    @IBAction func addPokemon(_ sender: Any) {
        if self.selectedUserPokemon == nil {
            navigationController?.popViewController(animated: true)
            // above: add button should actually be invisible an non-functional in this case
            return
        } else {
            UserPokemon.userAddedPokemon.append(self.selectedUserPokemon!)
//            userPokemonBrain.addPokemonToUserAddedPokemon(pokemon: self.selectedUserPokemon!)
            navigationController?.popViewController(animated: true)
            return
        }
    }
    
    // MARK: - Methods
    
    func updateViews() {
        if let pokemon = selectedUserPokemon {
            title = pokemon.name.capitalized
            idTextView.text = "ID: \(pokemon.id)"
            
            var typesText: String = "\(pokemon.types[0].type.name.capitalized)"
            if pokemon.types.count > 1 {
                for i in 1..<pokemon.types.count {
                    typesText.append(", \(pokemon.types[i].type.name.capitalized)")
                }
            }
            nameTextView.text = "Types: \(typesText)"
            
            var abilitiesText: String = "\(pokemon.abilities[0].ability.name.capitalized)"
            if pokemon.abilities.count > 1 {
                for i in 1..<pokemon.abilities.count {
                    abilitiesText.append(", \(pokemon.abilities[i].ability.name.capitalized)")
                }
            }
            abilitiesTextView.text = "Abilities: \(abilitiesText)"
            
            guard let imageURL = URL(string: pokemon.sprites.frontDefault) else { return }
            pokeImageView.load(url: imageURL)
        } else {
            title = "Search Pokemon"
        }
    }
    
    // MARK: - App Brains
    
    let userPokemonBrain = UserPokemon()
    let networkingBrain = Networking()
    let pokedex = Pokedex()
    
}

extension AddPokemon: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let pokemonSearch = searchBar.text,
            !pokemonSearch.isEmpty {
            networkingBrain.fetchPokemonByName(pokemon: pokemonSearch) { result in
                if let fetchedPokemon = try? result.get() {
                    DispatchQueue.main.async {
                        self.selectedUserPokemon = fetchedPokemon
                        self.updateViews()
                    }
                }
            }
            
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
