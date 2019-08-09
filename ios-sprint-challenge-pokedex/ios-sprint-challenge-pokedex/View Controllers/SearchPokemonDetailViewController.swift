//
//  SearchPokemonDetailViewController.swift
//  ios-sprint-challenge-pokedex
//
//  Created by Alex Shillingford on 8/9/19.
//  Copyright © 2019 Alex Shillingford. All rights reserved.
//

import UIKit

class SearchPokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
//    var pokemonImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    @IBAction func savePokemonButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        guard let pokemonController = pokemonController else { return }
        pokemonController.pokemonList.append(pokemon)
    }
    
    func updateViews(with pokemon: Pokemon) {
        guard let pokemonController = pokemonController else { return }
        pokemonName.text = pokemon.name
        idLabel.text = pokemon.id.description
        var typesList = ""
        var abilitiesList = ""
        
        for index in pokemon.types {
            if typesList.isEmpty {
                typesList = index.type.name
            } else if !typesList.isEmpty {
                typesList = typesList + ", " + index.type.name
            }
        }
        
        for index in pokemon.abilities {
            if abilitiesList.isEmpty {
                abilitiesList = index.ability.name
            } else if !abilitiesList.isEmpty {
                abilitiesList = abilitiesList + ", " + index.ability.name
            }
        }
        
        
        
        typesLabel.text = typesList
        abilitiesLabel.text = abilitiesList
//        self.pokemon = pokemon
    }
    
    func updateImageViews(with image: UIImage) {
        pokemonImage.image = image
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchPokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchingFor = searchBar.text else { return }
        guard let pokemonController = self.pokemonController else { return }
        pokemonController.searchPokemon(with: searchingFor) { (result) in
            if let pokemonResult = try? result.get() {
                self.pokemon = pokemonResult
                DispatchQueue.main.async {
                    self.updateViews(with: pokemonResult)
                }
                
                pokemonController.fetchImage(at: pokemonResult.sprites.frontDefault) { (result) in
                    if let imageResult = try? result.get() {
                        DispatchQueue.main.async {
                            self.updateImageViews(with: imageResult)
                        }
                    }
                }
            }
        }
    }
}
