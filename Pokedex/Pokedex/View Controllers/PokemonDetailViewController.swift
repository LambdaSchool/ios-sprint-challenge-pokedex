//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Isaac Lyons on 10/4/19.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    //MARK: Properties
    
    var pokemon: Pokemon?
    var pokemonController: PokemonController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        updateViews()
    }
    
    //MARK: Private
    
    private func updateViews() {
        if let pokemon = pokemon {
            saveButton.isEnabled = true
            saveButton.isHidden = false
            nameLabel.isHidden = false
            stackView.isHidden = false
            
            let name = pokemon.name.capitalizingFirstLetter()
            self.title = name
            nameLabel.text = name
            idLabel.text = "ID: \(pokemon.id)"
            
            var abilities = "Abilities: "
            for ability in pokemon.abilities {
                abilities += "\(ability.ability.name.capitalizingFirstLetter()), "
            }
            abilities = String(abilities.dropLast(2))
            abilitiesLabel.text = abilities
            
            var types = "Types: "
            for type in pokemon.types {
                types += "\(type.type.name.capitalizingFirstLetter()), "
            }
            types = String(types.dropLast(2))
            typesLabel.text = types
        } else {
            saveButton.isEnabled = false
            saveButton.isHidden = true
            nameLabel.isHidden = true
            stackView.isHidden = true
        }
        
        if pokemonController == nil {
            searchBar.isHidden = true
            saveButton.isEnabled = false
            saveButton.isHidden = true
        } else {
            searchBar.isHidden = false
        }
    }
    
    //MARK: Actions
    
    @IBAction func saveTapped(_ sender: UIButton) {
        if let pokemon = pokemon {
            pokemonController?.pokemonList.append(pokemon)
            navigationController?.popViewController(animated: true)
        }
    }
}

//MARK: Search Bar Delegate

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.view.endEditing(true)
        if let search = searchBar.text,
            !search.isEmpty{
            pokemonController?.getPokemon(from: search) { (result) in
                do {
                    let pokemon = try result.get()
                    
                    DispatchQueue.main.async {
                        self.pokemon = pokemon
                        self.updateViews()
                    }
                    
                    self.pokemonController?.fetchImage(at: pokemon.sprites.front_default, completion: { (result) in
                        do {
                            let image = try result.get()
                            
                            DispatchQueue.main.async {
                                self.imageView.image = image
                            }
                        } catch {
                            NSLog("Error getting image: \(error)")
                        }
                    })
                } catch {
                    NSLog("Error getting pokemon: \(error)")
                }
            }
        }
    }
}
