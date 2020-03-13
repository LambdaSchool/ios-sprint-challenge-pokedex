//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Wyatt Harrell on 3/13/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        nameLabel.isHidden = true
        imageView.isHidden = true
        typesLabel.isHidden = true
        abilitiesLabel.isHidden = true
        idLabel.isHidden = true
        saveButton.isHidden = true
        updateViews()
    }

    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        pokemonController?.getImage(at: pokemon.sprites.front_default, completion: { (result) in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        })
                        
        var name = pokemon.name
        name = name.prefix(1).uppercased() + name.lowercased().dropFirst()
        nameLabel.text = name
        idLabel.text = "ID: \(pokemon.id)"
            
        var types: String = ""
        var abilities: String = ""
        
        if pokemon.types.count > 1 {
            for item in pokemon.types {
                types += "\(item.type.name), "
            }
        } else {
            types = pokemon.types[0].type.name
        }
            
        if pokemon.abilities.count > 1 {
            for item in pokemon.abilities {
                abilities += "\(item.ability.name), "
            }
        } else {
            abilities = pokemon.abilities[0].ability.name
        }
            
        typesLabel.text = "Types: \(types)"
        abilitiesLabel.text = "Abilities: \(abilities)"
            
        nameLabel.isHidden = false
        imageView.isHidden = false
        typesLabel.isHidden = false
        abilitiesLabel.isHidden = false
        idLabel.isHidden = false
        saveButton.isHidden = false
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController?.pokedex.append(pokemon)
        navigationController?.popViewController(animated: true)
    }
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text else { return }
        
        pokemonController?.searchPokemon(with: search.lowercased()) { (result) in
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                }
                
                self.pokemonController?.getImage(at: pokemon.sprites.front_default, completion: { (result) in
                    if let image = try? result.get() {
                        DispatchQueue.main.async {
                            self.imageView.image = image
                            self.updateViews()
                        }
                    }
                })
            } catch {
                if let error = error as? NetworkError {
                    switch error {
                    case .generic:
                        NSLog("Generic error")
                    case .statusCode:
                        NSLog("Bad status code")
                    case .noData:
                        NSLog("No data received")
                    case .decodeError:
                        NSLog("Data could not be decoded")
                    case .badImageUrl:
                        NSLog("No image")
                    }
                }
            }
        }
    }
}
