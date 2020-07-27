//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Eoin Lavery on 22/07/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import UIKit

enum PokedexViewType {
    case search
    case saved
}

class PokemonViewController: UIViewController, UISearchBarDelegate {

    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: - Properties
    var pokemonController: PokemonController?
    var pokedexViewType: PokedexViewType?
    var pokemonIndex: Int?
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        if pokedexViewType == .saved {
            searchBar.isHidden = true
            saveButton.isHidden = true
            
            if let index = pokemonIndex{
                if let pokemon = pokemonController?.capturedPokemon[index] {
                    pokemonNameLabel.text = pokemon.name.capitalized
                    idLabel.text = "ID: \(pokemon.id)"
                           
                    var typesText = "Types: "
                    for type in pokemon.types {
                        typesText.append(contentsOf: type.type.name.capitalized)
                    }
                    typesLabel.text = typesText
                           
                    var abilitiesText = "Abilities: "
                    for ability in pokemon.abilities {
                        abilitiesText.append(contentsOf: ability.ability.name.capitalized)
                    }
                    abilitiesLabel.text = abilitiesText
                    
                    self.pokemonController?.getSprite(from: pokemon.sprites.front_default, completion: { (image) in
                        guard let image = image else {
                            print("Error retrieving spirte from server")
                            return
                        }
                        
                        DispatchQueue.main.async {
                            self.spriteImageView.image = image
                        }
                    })
                }
            }
        } else if pokedexViewType == .search {
            pokemonNameLabel.isHidden = true
            spriteImageView.isHidden = true
            idLabel.isHidden = true
            typesLabel.isHidden = true
            abilitiesLabel.isHidden = true
            saveButton.isHidden = true
        }
    }
    
    //MARK: - SearchBarDelegate Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonController = pokemonController else { return }
        guard let searchTerm = searchBar.text else { return}
        
        pokemonController.searchForPokemon(with: searchTerm) { (result) in
            
            guard let pokemon = try? result.get() else {
                print("Error retrieving Pokemon from Result object")
                return
            }
            
            self.pokemon = pokemon
            
            DispatchQueue.main.async {
                self.pokemonNameLabel.text = pokemon.name.capitalized
                self.idLabel.text = "ID: \(pokemon.id)"
                self.pokemonNameLabel.isHidden = false
                self.idLabel.isHidden = false
                       
                var typesText = "Types: "
                for type in pokemon.types {
                    typesText.append(contentsOf: type.type.name.capitalized)
                }
                self.typesLabel.text = typesText
                self.typesLabel.isHidden = false
                       
                var abilitiesText = "Abilities: "
                for ability in pokemon.abilities {
                    abilitiesText.append(contentsOf: ability.ability.name.capitalized)
                }
                self.abilitiesLabel.text = abilitiesText
                self.abilitiesLabel.isHidden = false
                
                self.pokemonController?.getSprite(from: pokemon.sprites.front_default, completion: { (image) in
                    guard let image = image else {
                        print("Error retrieving spirte from server")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.spriteImageView.image = image
                        self.spriteImageView.isHidden = false
                    }
                    
                })
                
                self.saveButton.isHidden = false
            }
            
        }
        
    }
    
    //MARK: - IBActions
    @IBAction func captureButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else {
            return
        }
        
        pokemonController?.capturePokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
}
