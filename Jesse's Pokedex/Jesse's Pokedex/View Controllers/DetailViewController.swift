//
//  DeatilViewController.swift
//  Pokedex
//
//  Created by Jesse Ruiz on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
   
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonAbility: UILabel!
    
    // MARK: - Properties
    var pokemonController: PokemonController!
    var pokemon: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getDetails() {
        pokemonController.searchForPokemon(with: pokemon) { (result) in
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                }
                self.pokemonController.fetchImage(at: pokemon.image) { (image) in
                    DispatchQueue.main.async {
                        self.pokemonImage.image = image
                    }
                }
            } catch {
                NSLog("Error fetching pokemon details: \(error)")
            }
        }
    }
    
    
    func updateViews(with pokemon: Pokemon) {
        
        title = pokemon.name
        pokemonName.text = pokemon.name
        pokemonID.text = String(pokemon.id)
        pokemonType.text = pokemon.type
        pokemonAbility.text = pokemon.ability
    }
    
}
