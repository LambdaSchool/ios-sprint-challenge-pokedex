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
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Properites
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return}
        
        pokemonController?.pokemonList.append(pokemon)
        pokemonController?.saveToPersistentStore()
        
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        searchBar.delegate = self
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemon = pokemon else {
            self.title = "Add New Pokemon"
            saveButton.setTitle("Save Pokemon", for: .normal)
            return
        }
        
        self.title = pokemon.name.capitalized
        self.pokemonNameLabel.text = pokemon.name.capitalized
        self.pokemonIdNumber.text = "ID: \(pokemon.id)"
        self.pokemonAbilitiesLabel.text = "Abilities: " + pokemon.abilities.map({$0.ability.name}).joined(separator: ", ")
        self.pokemonTypeLabel.text = "Types: " + pokemon.types.map({$0.type.name}).joined(separator: ", ")
        
        self.pokemonController?.fetchImage(at: pokemon.sprites.front_default) { (result) in
            guard let image = try? result.get() else { return }
            
            DispatchQueue.main.async {
                self.pokemonImage.image = image
            }
        }
    }
}



extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
                
        pokemonController!.fetchPokemon(name: searchTerm) { (result) in
            guard let pokemon = try? result.get() else { return }
            
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.updateViews()
            }
            
            self.pokemonController!.fetchImage(at: pokemon.sprites.front_default) { (result) in
                guard let image = try? result.get() else { return }
                
                DispatchQueue.main.async {
                    self.pokemonImage.image = image
                }
            }
        }
    }
}
