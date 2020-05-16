//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Bronson Mullens on 5/15/20.
//  Copyright © 2020 Bronson Mullens. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        pokeSearchBar.delegate = self
    }
    
    // MARK: - Properties
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    // MARK: - IBOutlets
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeID: UILabel!
    @IBOutlet weak var pokeTypeLabel: UILabel!
    @IBOutlet weak var pokeAbilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let pokemonController = pokemonController,
            let pokemon = pokemon {
            pokemonController.savePokemon(pokemon: pokemon)
            navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Functions
    func updateViews() {
        guard let pokemon = pokemon else {
            title = "Pokémon Search"
            hideUI()
            return
        }
        
        showUI()
        
        title = pokemon.name.capitalized
        pokeID.text = "ID: \(pokemon.id)"
        pokeTypeLabel.text = "Types: \(pokemon.types.joined(separator: ", "))"
        pokeAbilitiesLabel.text = "Abilities: \(pokemon.ability.joined(separator: ", "))"
        self.pokemonController?.fetchSprite(at: pokemon.sprites, completion: { (result) in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.pokeImage.image = image
                }
            }
        })
    }
    
    func hideUI() {
        pokeID.isHidden = true
        pokeTypeLabel.isHidden = true
        pokeAbilitiesLabel.isHidden = true
        saveButton.isHidden = true
    }
    
    func showUI() {
        pokeID.isHidden = false
        pokeTypeLabel.isHidden = false
        pokeAbilitiesLabel.isHidden = false
        saveButton.isHidden = false
    }
    
}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonName = pokeSearchBar.text else { return }
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
