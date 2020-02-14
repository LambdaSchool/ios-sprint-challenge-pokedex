//
//  PokemonSearchViewController.swift
//  PokeDex
//
//  Created by Enrique Gongora on 2/14/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    //MARK: - Variables
    var pokemonController: PokemonController!
    var pokemonDetailViewController: PokemonDetailViewController?
    var pokemon: Pokemon? {
        didSet {
            pokemonDetailViewController?.pokemon = pokemon
        }
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var savePokemon: UIButton!
    
    //MARK: - IBActions
    @IBAction func savePokemonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon, !pokemonController.pokemonList.contains(pokemon) else { return }
        pokemonController.pokemonList.append(pokemon)
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    //MARK: - Segue Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UIViewSegue" {
            guard let pokemonDetailVC = segue.destination as? PokemonDetailViewController else { return }
            pokemonDetailVC.pokemonController = self.pokemonController
            pokemonDetailVC.pokemon = self.pokemon
            self.pokemonDetailViewController = pokemonDetailVC
        }
    }
}

//MARK: - SearchBar Extension
extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
        pokemonController.fetchPokemon(name: searchTerm) { (result) in
            do {
                let pokemon = try result.get()
                self.pokemon = pokemon
            } catch {
                self.pokemon = nil
            }
        }
    }
}
