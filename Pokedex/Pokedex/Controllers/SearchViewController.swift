//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Bohdan Tkachenko on 5/16/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import UIKit
protocol PokemonProtocolDelegate {
    func addPokemon(with pockemon: Pokemon) -> Pokemon
}
class SearchViewController: UIViewController {
    
    var delegate: PokemonProtocolDelegate?
    var pokemonAPI: PokemonAPI = PokemonAPI()
    var pokemonImage: UIImage?
    
    @IBOutlet var pokemonSearchBar: UISearchBar!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var pokemonImageView: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonSearchBar.delegate = self
        
    }
    
    @IBAction func saveButtonaTapped(_ sender: Any) {
        // guard let pokemonAPI = pokemonAPI else { return }
        //delegate?.addPokemon(with: <#T##Pokemon#>)
        
        
    }
    
    private func updateViews(with pokemon: Pokemon) {
        
        nameLabel.text = pokemon.name
        idLabel.text = String(pokemon.id)
        typeLabel.text = pokemon.types.map { ($0 as String) }.compactMap({$0}).joined(separator: ", ")
        abilitiesLabel.text = pokemon.abilities.map { ($0 as String) }.compactMap({$0}).joined(separator: ", ")
        guard let image = pokemonImage else { return }
        pokemonImageView.image = image
        
        
    }
}




extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchName = searchBar.text else { return }
        searchBar.resignFirstResponder()
        
        self.pokemonAPI.getPokemon(with: searchName) { (result) in
            if let pokemon = try? result.get() {
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                    }
                self.pokemonAPI.fetchImage(at: pokemon.sprites) { (result) in
                    if let image = try? result.get() {
                        DispatchQueue.main.async {
                            self.pokemonImage = image
                        }
                    }
                }
            }
        }
    }
}
