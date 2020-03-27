//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Elizabeth Thomas on 3/20/20.
//  Copyright © 2020 Libby Thomas. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonIdNumber: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    // MARK: - Properites
    var pokemonController: PokemonController!
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return}
        print("\(pokemon)")
        
        pokemonController.pokemonList.append(pokemon)
        
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    


}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
                
        pokemonController.fetchPokemon(name: searchTerm) { (result) in
            guard let pokemon = try? result.get() else { return }
            
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.updateViews()
            }
            
            self.pokemonController.fetchImage(at: pokemon.sprites.front_default) { (result) in
                guard let image = try? result.get() else { return }
                
                DispatchQueue.main.async {
                    self.pokemonImage.image = image
                }
            }
        }
    }
    
    private func updateViews() {
       
        if let pokemon = pokemon {
        title = pokemon.name
        pokemonNameLabel.text = "\(pokemon.name)"
        pokemonIdNumber.text = "ID: \(String(pokemon.id))"
        pokemonTypeLabel.text = "Types: " + pokemon.types.map({$0.type.name}).joined(separator: ", ")
        pokemonAbilitiesLabel.text = "Abilities: " + pokemon.abilities.map({$0.ability.name}).joined(separator: ", ")
        } else {
            title = "Pokemon Search"
        }
    }
}
