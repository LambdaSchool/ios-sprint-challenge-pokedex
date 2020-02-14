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
    var pokemon: Pokemon?
    let apiController = APIController()
    
    // MARK: - Methods
    
    func updateViews(){
        guard let pokemon = pokemon else { return }
        pokemonNameLabel.text = pokemon.name
        idValueLabel.text = String(pokemon.id)
        typeLabel.text = pokemon.types.type.name
        abilitiesLabel.text = pokemon.abilities.ability
        
        apiController.fetchSprite(at: pokemon.name) { (result) in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.pokemonImage.image = image
                }
            }
        }
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
        
        
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
}
