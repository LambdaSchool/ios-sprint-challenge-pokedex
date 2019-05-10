//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Lisa Sampson on 5/10/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // MARK: - Properties and Outlets
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    // MARK: - View Loading Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViews()
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        title = pokemon.name.capitalized
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = String(pokemon.id)
        typeLabel.text = pokemon.types[0].type.name
        abilitiesLabel.text = pokemon.abilities[0].ability.name
//        pokemonImage.image = UIImage(contentsOfFile: pokemon.sprites.frontDefault)
    }
}
