//
//  DeatilViewController.swift
//  Pokedex
//
//  Created by Jesse Ruiz on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonAbility: UILabel!
    
    // MARK: - Properties
    var pokemonController: PokemonController!
    var pokemon: Pokemon?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pokemon = pokemon else { return }
        updateViews(with: pokemon)
    }
    
    func updateViews(with pokemon: Pokemon) {
        
        title = pokemon.name
        pokemonID.text = String(pokemon.id)
        pokemonType.text = pokemon.types.map({ $0.type.name.capitalized }).joined(separator: ", ")
        pokemonAbility.text = pokemon.abilities.map({ $0.ability.name.capitalized }).joined(separator: ", ")
        pokemonController.fetchImage(at: pokemon.sprites.front_default) { (image) in
            DispatchQueue.main.async {
            self.pokemonImage.image = image
            }
        }
    }
}
