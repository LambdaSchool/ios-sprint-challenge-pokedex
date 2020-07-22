//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Eoin Lavery on 22/07/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    /*func displayPokemon(with pokemon: Pokemon) {
        pokemonNameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        
        var typesText = "Types: "
        for type in pokemon.types {
            typesText.append(contentsOf: type.type.name)
        }
        typesLabel.text = typesText
        
        var abilitiesText = "Abilities: "
        for ability in pokemon.abilities {
            abilitiesText.append(contentsOf: ability.ability.name)
        }
        
        pokemonController?.getSprite(from: pokemon.sprites.front_default, completion: { (image) in
            guard let image = image else {
                print("Error retrieving spirte from server")
                return
            }
            
            
            self.spriteImageView.image = image
        })
    }*/
    
    //MARK: - SearchBarDelegate Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonController = pokemonController else { return }
        guard let searchTerm = searchBar.text else { return}
        
        pokemonController.searchForPokemon(with: searchTerm) { (result) in
            
            guard let pokemon = try? result.get() else {
                print("Error retrieving Pokemon from Result object")
                return
            }
            
            DispatchQueue.main.async {
                self.pokemonNameLabel.text = pokemon.name.capitalized
                self.idLabel.text = "ID: \(pokemon.id)"
                       
                var typesText = "Types: "
                for type in pokemon.types {
                    typesText.append(contentsOf: type.type.name)
                }
                self.typesLabel.text = typesText
                       
                var abilitiesText = "Abilities: "
                for ability in pokemon.abilities {
                    abilitiesText.append(contentsOf: ability.ability.name)
                }
                
                var sprite = UIImage()
                
                self.pokemonController?.getSprite(from: pokemon.sprites.front_default, completion: { (image) in
                    guard let image = image else {
                        print("Error retrieving spirte from server")
                        return
                    }
                    
                    sprite = image
                })
                
                self.spriteImageView.image = sprite
            }
            
        }
        
    }
    
}
