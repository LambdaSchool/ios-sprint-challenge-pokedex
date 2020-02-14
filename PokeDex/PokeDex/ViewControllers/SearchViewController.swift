//
//  SearchViewController.swift
//  PokeDex
//
//  Created by Chris Gonzales on 2/14/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Properties
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet{
            updateViews()
        }
    }
    let apiController = APIController()
    
    // MARK: - Methods
    
    func updateViews(){
        guard let pokemon = pokemon else { return }
        pokemonNameLabel.text = pokemon.name
        idValueLabel.text = String(pokemon.id)
        typeLabel.text = pokemonTypeString(pokemon: pokemon)
        abilitiesLabel.text = pokemonAbilityString(pokemon: pokemon)
        
    }
    
    func pokemonAbilityString(pokemon: Pokemon) -> String {
        var typeString = ""
        for attribute in pokemon.abilities{
            typeString += "\(attribute.ability.name)"
        }
        return typeString
    }
    
    func pokemonTypeString(pokemon: Pokemon) -> String {
        var typeString = ""
        for attribute in pokemon.types{
            typeString += "\(attribute.type.name)"
        }
        return typeString
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var idValueLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    
    // MARK: - Actions
    
    @IBAction func saveTapped(_ sender: UIButton) {
        guard let pokemon = pokemon,
        let pokemonController = pokemonController else { return }
        pokemonController.addPokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
}
