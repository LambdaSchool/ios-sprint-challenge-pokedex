//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Sammy Alvarado on 5/17/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var apiController: APIController?
    var pokemonName: String?
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idNumberLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getPokeDetails() {
        guard let apiController = apiController,
            let pokemonName = self.pokemonName else { return }
        apiController.fetchPokemon(searchTerm: pokemonName) { (result) in
            if let pokemon = try? result.get() {
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                }
            
            }
        }
    }
    
    private func updateViews( with pokemon: Pokemon) {
        title = pokemon.name
        idNumberLabel.text = "ID: \(pokemon.id)"
        typeLabel.text = "Type: \(pokemon.types)"
        abilitiesLabel.text = "Abilites: \(pokemon.abilites)"
    }
    

}
