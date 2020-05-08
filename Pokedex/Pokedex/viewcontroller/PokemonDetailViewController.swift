//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Vincent Hoang on 5/8/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import UIKit
import os.log

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var spriteImageVIew: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typesLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    @IBOutlet var saveButton: UIButton!
    
    var pokemon: Pokemon?
    
    let api = PokemonAPI()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        if let pokemon = pokemon {
            displayPokemon(for: pokemon)
            saveButton.isHidden = true
            searchBar.isHidden = true
        }
    }
    
    private func displayPokemon(for pokemon: Pokemon) {
        navigationController?.title = pokemon.name
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        
        var typeString = ""
        for pokemonType in pokemon.types {
//            for namedType in pokemonType.type {
//                typeString += "\(namedType.name) "
//            }
            typeString += "\(pokemonType.type.name.capitalized), "
        }
        typeString.removeLast()
        typeString.removeLast()
        
        typesLabel.text = "Types: \(typeString)"
        
        var abilitiesString = ""
        for ability in pokemon.abilities {
            
//            for namedAbility in ability.ability {
//                abilitiesString += "\(namedAbility.name) "
//            }
            
            abilitiesString += "\(ability.ability.name.capitalized), "
        }
        
        abilitiesString.removeLast()
        abilitiesString.removeLast()
        
        abilitiesLabel.text = "Abilities: \(abilitiesString)"
        
        if let spriteURL = URL(string: pokemon.sprites.front_default) {
            let task = URLSession.shared.dataTask(with: spriteURL, completionHandler: { data, _, error in
                
                if error != nil {
                    os_log("%@", "error")
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                DispatchQueue.main.async {
                    if let imageDownload = UIImage(data: data) {
                        self.spriteImageVIew.image = imageDownload
                    }
                }
                return
            })
            
            task.resume()
        }
    }
    
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        let query = searchBar.text ?? ""
//
//        if !query.isEmpty {
//            api.searchPokemon(for: query) { result in
//                do {
//                    let success = try result.get()
//
//                    DispatchQueue.main.async {
//                        self.saveButton.isHidden = false
//                        self.pokemon = success
//                        self.displayPokemon(for: success)
//                    }
//                } catch {
//                    return
//                }
//            }
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIButton, button === saveButton else {
            return
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = searchBar.text ?? ""
        
        if !query.isEmpty {
            api.searchPokemon(for: query) { result in
                do {
                    let success = try result.get()
                    
                    DispatchQueue.main.async {
                        self.saveButton.isHidden = false
                        self.pokemon = success
                        self.displayPokemon(for: success)
                        self.searchBar.resignFirstResponder()
                    }
                    
                } catch {
                    os_log("Error when searching")
                    return
                }
            }
        }
    }

}
