//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by John Kouris on 9/14/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

protocol SearchPokemonDetailsDelegate {
    func save(pokemon: Pokemon)
}

class PokemonSearchViewController: UIViewController {
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var savePokemonButton: UIButton!
    
    var pokemonController: PokemonController?
    var delegate: SearchPokemonDetailsDelegate?
    
    var pokemon: Pokemon? 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        savePokemonButton.isHidden = true
        pokemonNameLabel.isHidden = true
        idLabel.isHidden = true
        typesLabel.isHidden = true
        abilitiesLabel.isHidden = true
        title = "Pokemon Search"
        searchBar.delegate = self
        updateViews()
        
    }
    
    @IBAction func savePokemonButtonTapped(_ sender: UIButton) {
        if let pokemon = self.pokemon {
            self.delegate?.save(pokemon: pokemon)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func updateViews() {
        
        guard let pokemon = pokemon else { return }
        
        pokemonNameLabel.isHidden = false
        idLabel.isHidden = false
        typesLabel.isHidden = false
        abilitiesLabel.isHidden = false
        
        title = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        pokemonNameLabel.text = pokemon.name.capitalized
        
        if let image = try? Data(contentsOf: pokemon.sprites.frontDefault) {
            pokemonImageView.image = UIImage(data: image)
        }
        
        var types = "Types:\n"
        let typeArray = pokemon.types
        
        for type in typeArray {
            types.append("\(type.type.name.capitalized)\n")
        }
        
        typesLabel.text = types
        
        var abilities = "Abilities:\n"
        let abilityArray = pokemon.abilities
        
        for ability in abilityArray {
            abilities.append("\(ability.ability.name.capitalized)\n")
        }
        print(abilities)
        abilitiesLabel.text = abilities
        
    }
    
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, pokemonController != nil else { return }
        
        pokemonController?.searchForPokemon(with: searchTerm) { (result) in
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.savePokemonButton.isHidden = false
                    self.pokemon = pokemon
                    self.updateViews()
                }
                
            } catch {
                print("Error fetching results")
                return
            }
        }
    }
}
