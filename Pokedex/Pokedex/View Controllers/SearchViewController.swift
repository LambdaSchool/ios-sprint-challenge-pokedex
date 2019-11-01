//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Dennis Rudolph on 11/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    @IBOutlet weak var pokeSearch: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var PokeImageView: UIImageView!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearch.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    @IBAction func savePokemonButtonTapped(_ sender: UIButton) {
        guard let readyPokemon = pokemon else { return }
        pokemonController?.pokemon.append(readyPokemon)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func updateViews() {
        if let pokemon = pokemon {
            self.title = "\(pokemon.name.capitalized)"
            nameLabel.text = pokemon.name.capitalized
//            getImage(imageString: pokemon.sprites.front_default)
            IDLabel.text = ("ID: \(String(pokemon.id))")
            for aType in pokemon.types {
                typesLabel.text = ("Type(s): \(aType.type.name)")
            }
            for anAbility in pokemon.abilities {
                abilitiesLabel.text = ("Abilities: \(anAbility.ability.name)")
            }
        } else {
            self.title = "Pokemon Search"
        }
    }
    
//    func getImage(imageString: String) {
//        pokemonController?.fetchImage(at: imageString, completion: { result in
//
//        })
//    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text, !search.isEmpty else { return }
        pokemonController?.addPokemon(name: search.lowercased(), completion: { result in
            DispatchQueue.main.async {
                self.pokemon = result
                self.updateViews()
            }
        })
    }
}
