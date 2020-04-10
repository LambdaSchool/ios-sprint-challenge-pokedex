//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Harmony Radley on 4/10/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon: Pokemon?
    var pokemonController: PokemonController!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    
    @IBAction func savePokemonButtonTapped(_ sender: Any) {
        guard let pokemonName = pokemonNameLabel.text,
            let id = idLabel.text,
            let type = typesLabel.text,
            let abilities = abilitiesLabel.text,
            let image = imageView.image
            else { return }
        
        let pokemon = Pokemon(id: id, name: pokemonName, types: type, abilities: abilities)
        
        pokemonController.fetchAllPokemon(with: pokemon) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure(_):
                print("Error saving pokemon")
            }
        }
}
    
    
    func updateViews() {
        if let pokemon = pokemon {
            self.idLabel = pokemon.id
            typesLabel.text = pokemon.types
            abilitiesLabel.text = pokemon.abilities
            imageView.image = pokemon.image
        }
        
    }



}
