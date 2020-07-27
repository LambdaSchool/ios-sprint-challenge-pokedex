//
//  PokeSearchViewController.swift
//  PokedexSprintProject
//
//  Created by BrysonSaclausa on 7/18/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        if let pokemon = pokemon {
            self.updateViews(with: pokemon)
            searchBar.isHidden = true
        }
    }
        
        func updateViews(with pokemon: Pokemon) {
            title = pokemon.name.capitalized
            nameLabel.text = pokemon.name.capitalized
            idLabel.text = "ID: \(pokemon.id)"
            typeLabel.text = "Types: \(pokemon.types.joined(separator: ", "))"
            abilitiesLabel.text = "Abilities: \(pokemon.abilities.joined(separator: ", "))"
            guard let pokemonController = pokemonController else { return }
            pokemonController.fetchImage(at: pokemon.imageString) { (result) in
                if let image = try? result.get() {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
        

    @IBAction func SaveButton(_ sender: UIButton) {
            if let pokemonController = pokemonController,
                let pokemon = pokemon {
                pokemonController.pokemonResults.append(pokemon)
                navigationController?.popViewController(animated: true)
            }
        }
        
    }

extension SearchDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searching")
        guard let searchTerm = searchBar.text else { return }
        
        guard let pokemonController = pokemonController else { return }
        
        pokemonController.searchForPokemon(searchTerm) { result in
            
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                    self.searchBar.isHidden = true
                    self.pokemon = pokemon
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Error: \(error)")
                }
            }
        }
    }
    
}
