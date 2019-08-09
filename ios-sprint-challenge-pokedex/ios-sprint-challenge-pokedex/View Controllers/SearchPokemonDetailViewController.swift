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

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    @IBAction func savePokemonButtonTapped(_ sender: UIButton) {
        
    }
    
    func updateViews(with pokemon: Pokemon) {
        pokemonName.text = pokemon.name
        idLabel.text = pokemon.id.description
        typesLabel.text = pokemon.types.description
        abilitiesLabel.text = pokemon.abilities.description
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
                DispatchQueue.main.async {
                    self.updateViews(with: pokemonResult)
                }
            }
        }
    }
}
