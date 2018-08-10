//
//  ViewController.swift
//  Pokedex
//
//  Created by Carolyn Lea on 8/10/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController, UISearchBarDelegate
{
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitliesTextView: UITextView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Properties
    
    let pokemonController = PokemonController()
    var pokemons = [Pokemon]()
    
    // MARK: - Setup
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    
    // MARK: - Actions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        pokemonController.searchForPokemon(with: searchTerm) { (pokemons, error) in
            self.pokemons = pokemons ?? []
            
        }
    }
    
    @IBAction func save(_ sender: Any)
    {
        
    }
    
    private func updateViews()
    {
        
    }
}

