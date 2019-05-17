//
//  PokedexDetailViewController.swift
//  Pokedex
//
//  Created by Hayden Hastings on 5/17/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import UIKit

class PokedexDetailViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokedexSearchbar.delegate = self
    }
    
// MARK: -Methods
    
    func searchBarButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = pokedexSearchbar.text else { return }
        
        pokemonController.searchForPokemon(with: searchTerm) { (result) in
            if let pokemon = try? result.get() {
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                }
                self.pokemonController.fetchImage(at: pokemon.image, completion: { result in
                    if let image = try? result.get() {
                        DispatchQueue.main.async {
                            self.pokedexImageView.image = image
                        }
                    }
                })
            }
        }
    }
    
    func updateViews(with pokemon: Pokemon) {
     nameLabel.text = pokemon.name
        IDLabel.text = "\(pokemon.id)"
        abilityLabel.text = pokemon.abilities
        typesLabel.text = pokemon.types
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func savePokemonButtonPressed(_ sender: Any) {
        
    }
    
    @IBOutlet weak var pokedexSearchbar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var pokedexImageView: UIImageView!
    
    let pokemonController = PokemonController()
}
