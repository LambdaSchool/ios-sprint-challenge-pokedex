//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Norlan Tibanear on 7/18/20.
//  Copyright © 2020 Norlan Tibanear. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // Outlets
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typesLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    
    
    @IBOutlet var pokemonSearchBar: UISearchBar!
    @IBOutlet var pokemonImageView: UIImageView!
    @IBOutlet var pokemonIDLabel: UILabel!
    @IBOutlet var pokemonTypesLabel: UILabel!
    @IBOutlet var pokemonAbilitiesLabel: UILabel!
    @IBOutlet var pokemonSaveButton: UIButton!
    
    // Variables
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        pokemonSearchBar.delegate = self
        
        pokemonSaveButton.layer.cornerRadius = 5
        pokemonSaveButton.clipsToBounds = true
        
    }
    
        func updateViews() {
         guard let pokemon = pokemon else {
             title = "Search Pokemon"
//            pokemonSearchBar.isHidden = false
             hidenUI()
             return
         }
         visibleUI()
 //           pokemonSearchBar.isHidden = true
            title = pokemon.name.capitalized
         pokemonIDLabel.text = String(pokemon.id)
         pokemonTypesLabel.text = pokemon.types.joined(separator: ", ")
    pokemonAbilitiesLabel.text = pokemon.ability.joined(separator: ", ")
         self.pokemonController?.fetchSprite(at: pokemon.sprites, completion: { (result) in
             if let image = try? result.get() {
                 DispatchQueue.main.async {
                     self.pokemonImageView.image = image
                 }
             }
         })
     }
     
     func hidenUI() {
         idLabel.isHidden = true
         typesLabel.isHidden = true
         abilitiesLabel.isHidden = true
        
         pokemonIDLabel.isHidden = true
         pokemonTypesLabel.isHidden = true
         pokemonAbilitiesLabel.isHidden = true
         pokemonSaveButton.isHidden = true
     }
     
     func visibleUI() {
         idLabel.isHidden = false
         typesLabel.isHidden = false
         abilitiesLabel.isHidden = false
        
         pokemonIDLabel.isHidden = false
         pokemonTypesLabel.isHidden = false
         pokemonAbilitiesLabel.isHidden = false
         pokemonSaveButton.isHidden = false
     }
     
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        if let pokemonController = pokemonController,
            let pokemon = pokemon {
            pokemonController.savePokemon(pokemon: pokemon)
            navigationController?.popViewController(animated: true)
        }
    }
    
    
 } //

    

    
    




extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonName = pokemonSearchBar.text else { return }
        pokemonController?.fetchPokemon(with: pokemonName, completion: { (result) in
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

