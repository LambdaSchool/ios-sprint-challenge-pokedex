//
//  PokémonSearchViewController.swift
//  Pokédex
//
//  Created by Samantha Gatt on 8/10/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViews()
    }
    
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController?.get(nameOrID: searchTerm, completion: { (error, pokemon) in
            if let error = error {
                NSLog("Error getting pokemon, \(searchTerm): \(error)")
                return
            }
            
            guard let thisPokemon = pokemon else { return }
            self.pokemon = thisPokemon
        })
    }
    
    
    // MARK: - Functions
    
    func updateViews() {
        guard let _ = pokemon else {
            pokemonView.isHidden = true
            return
        }
        pokemonView.isHidden = false
    }
    
    
    
    // MARK: - Properties
    
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    var pokemonController: PokemonController?

    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonView: UIView!
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedSearch" {
            let destVC = segue.destination as! PokemonViewController
            guard let thisController = pokemonController else { fatalError("PokemonSearchViewController has no pokemonController property") }
            destVC.pokemonController = thisController
        }
    }
}
