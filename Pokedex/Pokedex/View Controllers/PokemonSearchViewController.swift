//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Mitchell Budge on 5/17/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pokemonNameLabel.text = ""
        pokemonIDLabel.text = ""
        pokemonTypeLabel.text = ""
        pokemonAbilityLabel.text = ""
        saveButton.setTitleColor(.white, for: .normal)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilityLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    func updateViews(pokemon: Pokemon?) {
        guard let pokemon = pokemon else { return }
        pokemonNameLabel.text = pokemon.name
        pokemonIDLabel.text = String(pokemon.id)
        let pokemonTypes: [String] = pokemon.types.map{$0.type.name}
        pokemonTypeLabel.text = "\(pokemonTypes.joined(separator: ", "))"
        let pokemonAbilities: [String] = pokemon.abilities.map{$0.ability.name}
        pokemonAbilityLabel.text = "\(pokemonAbilities.joined(separator: ", "))"
        guard let url = URL(string: pokemon.sprites.frontDefault), let image = try? Data(contentsOf: url) else { return }
        pokemonImageView.image = UIImage(data: image)
        saveButton.setTitleColor(.blue, for: .normal)
        searchBar.isHidden = true
    } // end of update views
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchedPokemon = searchBar.text?.lowercased(), searchBar.text != "" else { return }
        pokemonController?.searchPokemon(with: searchedPokemon, completion: { (result) in
                do { let pokemon = try result.get()
                    self.pokemon = pokemon
                    DispatchQueue.main.async {
                        self.updateViews(pokemon: pokemon)
                    }
                } catch {
                    NSLog("Error searching for Pokemon: \(error)")
                    return
                }
        })
    } // end of search bar
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        pokemonController?.pokemon.append(pokemon)
        navigationController?.popViewController(animated: true)
    } // end of save button
}
