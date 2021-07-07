//
//  PokemonSearchViewController.swift
//  SprintChallenge-Pokedex
//
//  Created by Ciara Beitel on 9/6/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    var pokemonController: PokemonController!
    
    var pokemon: Pokemon?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBAction func savePokemonButton(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController.pokemons.append(pokemon)
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name.capitalized
        guard let url = URL(string: pokemon.sprites.front_shiny) else { return }
        image.load(url: url)
        idLabel.text = "\(pokemon.id)"
        var typesString = ""
        for type in pokemon.types {
            typesString += type.type.name + ", "
        }
        typesLabel.text = typesString
        var abilitiesString = ""
        for ability in pokemon.abilities {
            abilitiesString += ability.ability.name + ", "
        }
        abilitiesLabel.text = abilitiesString
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text?.lowercased() else { return }
        pokemonController.getPokemon(name: searchText) { (result) in
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                }
                
            } catch {
                NSLog("Error getting Pokemon: \(error)")
            }
            
        }
    }
}
