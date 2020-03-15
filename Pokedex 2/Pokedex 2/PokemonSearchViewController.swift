//
//  PokemonSearchViewController.swift
//  Pokedex 2
//
//  Created by Bhawnish Kumar on 3/14/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var buttonTapped: UIButton!
    
    var pokemonController: PokemonController!
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar?.delegate = self
        if pokemon == nil {
            searchBar?.delegate = self
            
        } else {
            self.searchBar?.removeFromSuperview()
            self.buttonTapped?.removeFromSuperview()
        }
        
        
    }
    
    @IBAction func savePokemon(_ sender: Any) {
        guard let pokemon = pokemon,
            !pokemonController.pokemonList.contains(pokemon) else { return }
        
        pokemonController.pokemonList.append(pokemon)
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    func updateViews() {
        if let pokemon = pokemon {
            updatePokemon(with: pokemon)
        } else {
        DispatchQueue.main.async {
             self.pokemonNameLabel.text = ""
                            self.pokemonIDLabel.text = ""
                            self.pokemonTypesLabel.text = ""
                            self.pokemonAbilitiesLabel.text = " "
                            self.pokemonImageView.image = nil
          }
            
        }
        }
    
    
    private func updatePokemon(with pokemon: Pokemon) {
        pokemonController?.fetchImage(at: pokemon.spritesName) { result in
            do {
                let pokemonImage = try result.get()
                self.updateImage(with: pokemonImage)
            } catch {
                self.pokemonImageView.image = nil
            }
        }
        
        DispatchQueue.main.async {
            self.pokemonNameLabel.text = pokemon.name.capitalized
            self.pokemonIDLabel.text = "ID: " + String(pokemon.id)
            self.pokemonTypesLabel.text = "Types: \(pokemon.typesName)"
            self.pokemonAbilitiesLabel.text = "Abilities: \(pokemon.abilitiesName)"
        }
    }
    
    private func updateImage(with image: UIImage) {
        DispatchQueue.main.async {
            self.pokemonImageView.image = image
        }
    }
    

    
}
    
extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
        
        pokemonController.fetchPokemon(with: searchTerm) { result in
            do {
                let pokemon = try result.get()
                self.pokemon = pokemon
            } catch {
                self.pokemon = nil
            }
        }
    }
}
