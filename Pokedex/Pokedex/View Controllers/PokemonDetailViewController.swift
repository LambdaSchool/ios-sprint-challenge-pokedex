//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Kelson Hartle on 5/8/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var pokemonNameTitle: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    //MARK: - Properties

    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    //MARK: - Functions
    
    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemon = pokemon else { return }
        pokemonNameTitle.text = pokemon.name
        pokemonIdLabel.text = "ID: \(String(pokemon.id))"
        pokemonTypesLabel.text = "Types: \(pokemon.types)"
        abilitiesLabel.text = "Abilities: \(pokemon.abilities)"
        
        self.pokemonController?.getPokemonImage(at: pokemon.sprites) { result in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.pokemonImage.image = image
                }
            }
        }
    }
}




