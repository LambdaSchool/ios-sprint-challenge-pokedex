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
    @IBOutlet weak var abilitiesTextView: UITextView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Properties
    
    var pokemonController = PokemonController()
    var pokemons = [Pokemon]()
    var pokemon: Pokemon?
    {
        didSet
        {
            updateViews()
        }
    }
    
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
            
            DispatchQueue.main.async {
                self.updateViews()
            }
            
        }
    }
    
    @IBAction func save(_ sender: Any)
    {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        pokemonController.createPokemon(name: searchTerm) { (error) in
            if let error = error
            {
                NSLog("problem \(error)")
                return
            }
            
        }
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func updateViews()
    {
//        guard let pokemon = pokemon else {
//            title = "Search Pokemon"
//            return
//        }
//        let x: Int = pokemon.id
//        let stringValue = "\(x)"
//        title = pokemon.name
//        nameLabel.text = pokemon.name
//        idLabel.text = stringValue
//        typeLabel.text = pokemon.types
//        abilitiesTextView.text = pokemon.abilities
        let x: Int = 100
        let stringValue = "\(x)"
        title = "Name goes here"
        nameLabel.text = "name goes here"
        idLabel.text = stringValue
        typeLabel.text = "type goes here"
        abilitiesTextView.text = "abilities go here"
    }
}

