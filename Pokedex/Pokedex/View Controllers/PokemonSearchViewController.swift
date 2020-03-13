//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Shawn Gee on 3/13/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var savePokemonButton: UIButton!
    @IBOutlet weak var pokemonDetailContainerView: UIView!
    
    
    // MARK: - IBActions
    
    @IBAction func savePokemonTapped(_ sender: Any) {
        guard let pokemon = pokemonDetailVC?.pokemon else { return }
        pokedex?.pokemon.append(pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Properties
    
    var pokeApiClient: PokeApiClient?
    var pokedex: Pokedex?
    
    
    // MARK: - Private
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var pokemonDetailVC: PokemonDetailViewController?
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonDetailContainerView.layer.opacity = 0
        setupSearchController()
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetail", let pokemonDetailVC = segue.destination as? PokemonDetailViewController {
            pokemonDetailVC.pokeApiClient = pokeApiClient
            self.pokemonDetailVC = pokemonDetailVC
        }
    }

}


// MARK: - UISearchBarDelegate

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        pokeApiClient?.fetchPokemon(withName: searchText, completion: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.pokemonDetailContainerView.layer.opacity = 1
                    self.pokemonDetailVC?.pokemon = pokemon
                    self.title = pokemon.name.capitalized
                    self.savePokemonButton.isEnabled = true
                    self.searchController.dismiss(animated: true)
                case .failure(let error):
                    NSLog("\(error)")
                }
            }
        })
    }
}
