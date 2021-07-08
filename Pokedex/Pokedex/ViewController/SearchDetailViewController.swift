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
    
    var isViewingDetail: Bool?
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    {
        didSet
        {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    // MARK: - Setup
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        searchBar.autocapitalizationType = .none 
        updateViews()
        
    }

    
    // MARK: - Actions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        pokemonController?.searchForPokemon(with: searchTerm) { (pokemon, error)  in
            self.pokemon = pokemon ?? nil
            
        }
        
        
        DispatchQueue.main.async {
            
            self.updateViews()
            
        }
        
        
    }
    
    @IBAction func save(_ sender: Any)
    {
        guard let name = pokemon?.name,
            let id = pokemon?.id,
            let abilities = pokemon?.abilities,
            let types = pokemon?.types else {return}
        pokemonController?.createPokemon(name: name, id: id, abilities: abilities, types: types)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private
    
    private func updateViews()
    {
        guard let pokemon = pokemon else
        {
            title = "Search Pokemon"
            
            nameLabel.text = ""
            idLabel.text = ""
            typeLabel.text = ""
            abilitiesTextView.text = ""
            saveButton.isHidden = true
            return
        }
        
        title = pokemon.name
        let x: Int = pokemon.id
        let stringValue = "\(x)"

        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(stringValue)"
        typeLabel.text = "Types: " + pokemon.types.map({ $0.type.name }).joined(separator: ", ")
        abilitiesTextView.text = "Abilities: " + pokemon.abilities.map({ $0.ability.name}).joined(separator: ", ")
        
        saveButton.isHidden = false
        
        if isViewingDetail!
        {
            saveButton.isHidden = true
            searchBar.isHidden = true
        }
    }
}

