//
//  PokemonDetailViewController.swift
//  Sprint3
//
//  Created by Kobe McKee on 5/17/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonAbilities: UILabel!
    @IBOutlet weak var pokemonTypes: UILabel!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonSprite: UIImageView!
    
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        pokemonName.text = pokemon.name.capitalized
        pokemonID.text = String(pokemon.id)
        
        
        let abilities: [String] = pokemon.abilities.map { $0.ability.name }
        pokemonAbilities.text = "Abilities: \n\(abilities.joined(separator: "\n"))"
        
        let type: [String] = pokemon.types.map { $0.type.name }
        pokemonTypes.text = "Type(s): \n\(type.joined(separator: "\n"))"

        guard let url = URL(string: pokemon.sprites.frontDefault),
            let pokemonImageData = try? Data(contentsOf: url) else { return }
        pokemonSprite.image = UIImage(data: pokemonImageData)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        navigationItem.title = pokemon?.name
    }
    


}
