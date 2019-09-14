//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by John Kouris on 9/14/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var savePokemonButton: UIButton!
    
    private let pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonNameLabel.isHidden = true
        pokemonImageView.isHidden = true
        idLabel.isHidden = true
        typesLabel.isHidden = true
        abilitiesLabel.isHidden = true
        savePokemonButton.isHidden = true
        
        
    }
    
    @IBAction func savePokemonButtonTapped(_ sender: UIButton) {
        
    }
    
    func updateViews(with pokemon: Pokemon) {
        
        title = pokemon.name
        
        self.pokemonNameLabel.isHidden = false
        self.pokemonImageView.isHidden = false
        self.idLabel.isHidden = false
        self.typesLabel.isHidden = false
        self.abilitiesLabel.isHidden = false
        self.savePokemonButton.isHidden = false
        
        pokemonNameLabel.text = pokemon.name
        typesLabel.text = "\(pokemon.types[0])"
        abilitiesLabel.text = "\(pokemon.abilities)"
        idLabel.text = "\(pokemon.id)"
        
    }
    
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        pokemonController.searchForPokemon(with: searchTerm) { (result) in
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                }
                
                self.pokemonController.fetchSprite(at: pokemon.sprites.frontDefault, completion: { (result) in
                    if let image = try? result.get() {
                        DispatchQueue.main.async {
                            self.pokemonImageView.image = image
                        }
                    }
                })
            } catch {
                print("Error fetching results")
                return
            }
        }
    }
}
