//
//  SearchPokemonViewController.swift
//  Pokedex
//
//  Created by Hayden Hastings on 5/17/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import UIKit

class SearchPokemonViewController: UIViewController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        nameLabel.text = ""
        typesLabel.text = ""
        IDLabel.text = ""
        abilityLabel.text = ""
        saveButton.isHidden = true
    }
    
    // MARK: -Methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchPokemon = searchBar.text?.lowercased(), searchBar.text != "" else { return }
        
        pokemonController.searchForPokemon(with: searchPokemon, completion: { (result) in
            
            do {
                
                let pokemon = try result.get()
                self.pokemon = pokemon
                
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                }
                
            } catch {
                
                NSLog("Error searching for Pokemon: \(error)")
                return
            }
        })
    }
    
    func updateViews(with pokemon: Pokemon?) {
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name
        IDLabel.text = String(pokemon.id)
        let pokemonTypes: [String] = pokemon.types.map{ $0.type.name}
        typesLabel.text = "\(pokemonTypes.joined(separator: ", "))"
        let pokemonAbilities: [String] = pokemon.abilities.map{ $0.ability.name }
        abilityLabel.text = "\(pokemonAbilities.joined(separator: ", "))"
        
        guard let url = URL(string: pokemon.sprites.frontDefault),
            let image = try? Data(contentsOf: url) else { return }
        pokedexImageView.image = UIImage(data: image)
        saveButton.isHidden = false
        
        navigationItem.title = pokemon.name
        
    }
    
    @IBAction func savePokemonButtonPressed(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController.pokemon.append(pokemon)
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var pokedexImageView: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    var pokemon: Pokemon?
    var pokemonControlle: PokemonController?
    var pokemonController = PokemonController()
}
