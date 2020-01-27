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
    
    var pokemon: Pokemon? {
        didSet {
            pokemonDetailViewController?.pokemon = pokemon
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var savePokemonButton: UIButton?
    
    // MARK: - IBActions

    @IBAction func savePokemonButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        
        pokemonController.pokemonList.append(pokemon)
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar?.delegate = self
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "EmbeddedPokemonDetailVC",
        let pokemonDetailVC = segue.destination as? PokemonDetailViewController else { return }
        
        pokemonDetailVC.pokemonController = self.pokemonController
        self.pokemonDetailViewController = pokemonDetailVC
    }
}

// MARK: - Search Bar Delegate

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
                
        pokemonController.fetchPokemon(with: searchTerm) { result in
            do {
                let pokemon = try result.get()
                self.pokemon = pokemon
            } catch {
                self.pokemon = nil
            }
        }
    }
}
