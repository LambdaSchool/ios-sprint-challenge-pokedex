//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Kat Milton on 6/21/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var pokemonIDLabel: UILabel!
    @IBOutlet var pokemonTypesLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    @IBOutlet var spriteDisplay: UIImageView!
    
    
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        title = pokemon?.name.capitalized
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        pokemonNameLabel.text = pokemon.name.capitalized
        pokemonIDLabel.text = String("ID: \(pokemon.id)")
        let abilities: [String] = pokemon.abilities.map { $0.ability.name }
        abilitiesLabel.text = "Abilities: \(abilities.joined(separator: "\n"))"
        let type: [String] = pokemon.types.map { $0.type.name }
        pokemonTypesLabel.text = "Type(s): \(type.joined(separator: ", "))"
        
        guard let url = URL(string: pokemon.sprites.front_default),
            let spriteData = try? Data(contentsOf: url) else { return }
        spriteDisplay.image = UIImage(data: spriteData)
        
    }

   

}
