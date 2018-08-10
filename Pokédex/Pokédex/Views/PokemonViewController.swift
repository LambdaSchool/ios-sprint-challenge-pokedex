//
//  PokémonViewController.swift
//  Pokédex
//
//  Created by Samantha Gatt on 8/10/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViews()
    }
    
    // MARK: - Functions
    
    func updateViews() {
        
        guard let thisPokemon = pokemon else { return }
        
        nameLabel.text = thisPokemon.name
        pokemonIDLabel.text = thisPokemon.id
        pokemonTypesLabel.text = thisPokemon.types
        pokemonAbilitiesLabel.text = thisPokemon.abilities
    }
    
    
    // MARK: - Actions
    
    @IBAction func save(_ sender: Any) {
        
    }
    
    
    // MARK: - Properties
    
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                updateViews()
            }
        }
    }
    var pokemonController: PokemonController?
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
}
