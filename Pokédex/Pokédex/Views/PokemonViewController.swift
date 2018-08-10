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
        pokemonIDLabel.text = "\(thisPokemon.id)"
        
        if let types = thisPokemon.allTypes,
            let abilities = thisPokemon.allAbilities {
            
            pokemonTypesLabel.text = types
            pokemonAbilitiesLabel.text = abilities
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func save(_ sender: Any) {
        guard let thisPokemon = pokemon else { return }
        pokemonController?.create(pokemon: thisPokemon)
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
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
}
