//
//  AddViewController.swift
//  Pokedex
//
//  Created by Lydia Zhang on 3/13/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var ability: UITextView!
    
    var pokemonController: PokemonController!
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        searchBar.delegate = self
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if let pokemonController = pokemonController, let pokemon = pokemon {
            pokemonController.savePokemon(for: pokemon)
            navigationController?.popViewController(animated: true)
        }
    }
    func updateViews() {
        guard let pokemon = pokemon else {
            title = "Pokemon Search"
            name.isHidden = true
            image.isHidden = true
            id.isHidden = true
            type.isHidden = true
            ability.isHidden = true
            return
        }
        title = name.text
        name.isHidden = false
        image.isHidden = false
        id.isHidden = false
        type.isHidden = false
        ability.isHidden = false
        searchBar.isHidden = true
        pokemonController?.fetchPokemonImage(at: pokemon.sprites.url, completion: { result in
            do {
                let imageView = try result.get()
                self.image.image = imageView
            } catch {
                self.image.image = nil
            }
        })
        
        name.text = pokemon.name
        id.text = String(pokemon.id)
        
        var x: [String] = []
        for types in pokemon.types {
            x.append(types.type.typeName)
        }
        var y: [String] = []
        for abilities in pokemon.abilities {
            y.append(abilities.ability.abilityName)
        }
        
        type.text = x.joined(separator: ",")
        ability.text = y.joined(separator: ",")
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchbar: UISearchBar) {
        guard let identifier = searchbar.text?.lowercased() else {return}
        
        pokemonController?.fetchPokemon(name: identifier, completion: { result in
            let pokemon = try? result.get()
            if let pokemon = pokemon {
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                }
            }
            
        })
    }
}
