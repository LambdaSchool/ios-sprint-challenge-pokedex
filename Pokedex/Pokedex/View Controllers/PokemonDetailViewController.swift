//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Michael Stoffer on 6/1/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // MARK: - IBOutlets and Properties
    @IBOutlet var pokemonSearchBar: UISearchBar!
    @IBOutlet var pokemonView: UIView!
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var pokemonImageView: UIImageView!
    @IBOutlet var pokemonIdLabel: UILabel!
    @IBOutlet var pokemonTypesLabel: UILabel!
    @IBOutlet var pokemonAbilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pokemonSearchBar.delegate = self
        self.pokemonView.isHidden = true
    }
    
    // MARK: - IBActions and Methods
    @IBAction func savePokemon(_ sender: UIButton) {
    }
    
    func updateViews(with pokemon: Pokemon) {
        self.title = pokemon.name
        self.pokemonNameLabel.text = pokemon.name.capitalized
        self.pokemonImageView.image = UIImage(contentsOfFile: pokemon.sprites.front_default)
        self.pokemonIdLabel.text = String(pokemon.id)
//        self.pokemonTypesLabel.text = pokemon.types
//        self.pokemonAbilitiesLabel.text = pokemon.abilities
        self.pokemonView.isHidden = false
    }
}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonController = self.pokemonController,
            let searchTerm = self.pokemonSearchBar.text else { return }
        
        pokemonController.searchForPokemon(searchTerm: searchTerm, completion: { (result) in
            if let pokemon = try? result.get() {
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                }
            }
        })
    }
}
