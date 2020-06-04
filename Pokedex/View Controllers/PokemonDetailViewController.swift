//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Andrew Ruiz on 10/4/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    var apiController: APIController!
    var pokemonName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getPokemonDetails() {
        apiController.fetchPokemon(for: pokemonName) { (result) in
            
            do {
                let pokemon = try result.get()
                
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                }
                
                self.apiController.fetchPokemonImage(at: pokemon.imageURL) { (image) in
                    DispatchQueue.main.async {
                        self.pokemonImageView.image = image
                    }
                }
            } catch {
                NSLog("Error fetching pokemon details: \(error)")
            }
        }
    }
    
    func updateViews(with pokemon: Pokemon) {
        
        pokemonNameLabel.text = pokemon.name
        pokemonTypeLabel.text = pokemon.types.type.name
        pokemonIDLabel.text = pokemonIDLabel.text
        
    }
    
    @IBAction func savePokemonButtonTapped(_ sender: Any) {
    }
    
}
