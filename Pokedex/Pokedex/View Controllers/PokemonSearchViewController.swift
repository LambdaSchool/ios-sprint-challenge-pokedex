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
    
    var pokemonController: PokemonController? {
        didSet {
            print("yep")
        }
    }
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        
        var types: String = ""
        var abilities: String = ""
        
        if pokemon.types.count > 1 {
            for item in pokemon.types {
                types += "\(item.type.name), "
                #warning("--fix extra comma--")
            }
        } else {
            types = pokemon.types[0].type.name
        }
        
        if pokemon.abilities.count > 1 {
            for item in pokemon.abilities {
                abilities += "\(item.ability.name), "
                #warning("--fix extra comma--")
            }
        } else {
            abilities = pokemon.abilities[0].ability.name
        }
        
        typesLabel.text = "Types: \(types)"
        abilitiesLabel.text = "Abilities: \(abilities)"
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
                }
                
                self.pokemonController?.getImage(at: pokemon.sprites.front_default, completion: { (result) in
                    if let image = try? result.get() {
                        DispatchQueue.main.async {
                            self.imageView.image = image
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
