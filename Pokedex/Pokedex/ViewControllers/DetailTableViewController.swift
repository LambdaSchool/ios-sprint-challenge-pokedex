//
//  DetailTableViewController.swift
//  Pokedex
//
//  Created by Marissa Gonzales on 5/8/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

class DetailTableViewController: UIViewController {
    
    
    
    
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    var pokeResultController: PokemonResultsController?
    var pokemon: PokeResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func updateViews() {
        if let pokemon = pokemon {
            pokemonNameLabel.text = pokemon.name
            title = pokemon.name
            idLabel.text = String(pokemon.id)
        } else {
            title = "Pokedex Search"
        }
    }
    
    private func searchResults() {
        guard let searchedPokemon = searchBar.text,
            !searchedPokemon.isEmpty else { return }
        
        pokeResultController?.performSearch(for: searchedPokemon, completion: { result in
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.title = pokemon.name
                    self.pokemonNameLabel.text = pokemon.name
                    self.idLabel.text = String(pokemon.id)
                }
            } catch {
                print("Could Not Find Pokemon")
            }
        })
        
    }
    
    
    @IBAction func saveButtonFunc(_ sender: Any) {
    }
}
extension DetailTableViewController: UISearchBarDelegate {
    func searchButtonTapped(_ searchBar: UISearchBar) {
        searchResults()
    }
}
