//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Shawn Gee on 3/13/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {

    
    // MARK: - Properties
    
    var pokeApiClient: PokeApiClient?
    
    
    // MARK: - Private
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var pokemonDetailVC: PokemonDetailViewController?
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetail" {
            pokemonDetailVC = segue.destination as? PokemonDetailViewController
        }
    }

}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        pokeApiClient?.fetchPokemon(withName: searchText, completion: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.pokemonDetailVC?.pokemon = pokemon
                case .failure(let error):
                    NSLog("\(error)")
                }
            }
        })
    }
}
