//
//  PokemonSearchViewController.swift
//  PokeDex
//
//  Created by Dojo on 7/19/20.
//  Copyright © 2020 Dojo. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
   
   
    var pokemonController = PokemonController()
    var pokemonDetailViewController: PokemonDetailViewController?

    var pokemon: Pokemon? {
        didSet {
            updateNavigationItemTitle()
            pokemonDetailViewController?.pokemon = pokemon
        }
    }

    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var savePokemonButton: UIButton?

    
    @IBAction func savePokemonButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon,
            !pokemonController.pokemonList.contains(pokemon) else { return }

        pokemonController.pokemonList.append(pokemon)

        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }

   
    
    private func updateNavigationItemTitle() {
        DispatchQueue.main.async {
            self.navigationItem.title = self.pokemon?.name.capitalized ?? "Pokemon Search"
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar?.delegate = self
        if pokemon == nil {
            searchBar?.delegate = self
        } else {
            self.searchBar?.removeFromSuperview()
            self.savePokemonButton?.removeFromSuperview()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "EmbeddedPokemonDetailVC",
        let pokemonDetailVC = segue.destination as? PokemonDetailViewController else { return }

        pokemonDetailVC.pokemonController = self.pokemonController
        pokemonDetailVC.pokemon = self.pokemon
        self.pokemonDetailViewController = pokemonDetailVC
    }
}


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
