//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Matthew Martindale on 3/22/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var pokemonController: PokemonController? = nil
    var pokemon: Pokemon?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        var types = ""
        pokemon.types.forEach { pokemon in
            types.append("\(pokemon.type.name) ")
        }
        
        var abilities = ""
        pokemon.abilities.forEach { pokemon in
            abilities.append("\(pokemon.ability.name) ")
        }
        
        
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        typesLabel.text = "Type: \(types)"
        abilitiesLabel.text = "Abilities: \(abilities)"
        getPokemonImage()
    }

    func getPokemonImage() {
        guard let pokemonSprite = pokemon?.sprites.frontDefault else { return }
        if let url = URL(string: pokemonSprite) {
            do {
                let data = try Data(contentsOf: url)
                self.imageView.image = UIImage(data: data)
            } catch let err {
                print("Error loading sprite image: \(err.localizedDescription)")
            }
        }
    }
    
}
