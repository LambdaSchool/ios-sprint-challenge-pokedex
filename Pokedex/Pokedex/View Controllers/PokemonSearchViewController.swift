//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by David Wright on 1/26/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {

    // MARK: - Properties
    
    var pokemonController: PokemonController!
    var pokemonDetailViewController: PokemonDetailViewController?
    var pokemon: Pokemon?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var savePokemonButton: UIButton!
    
    // MARK: - Actions

    @IBAction func savePokemonButtonTapped(_ sender: UIButton) {
        // TODO: Implement savePokemonButtonTapped()
    }
    
    // MARK: - Private Methods
    
    private func updateDataSource() {
        guard let searchTerm = searchBar.text else { return }
        
        print("Searching for \"\(searchTerm)\"...")
        
        // TODO: Call perform search method
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "EmbeddedPokemonDetailVC",
        let pokemonDetailVC = segue.destination as? PokemonDetailViewController else { return }
        
        pokemonDetailVC
        self.pokemonDetailViewController = pokemonDetailVC
    }

}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateDataSource()
    }
}
