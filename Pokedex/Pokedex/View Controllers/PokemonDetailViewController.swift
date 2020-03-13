//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Wyatt Harrell on 3/13/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemon: Pokemon?
    var pokemonController: PokemonController?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateViews()
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        pokemonController?.getImage(at: pokemon.sprites.front_default, completion: { (result) in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        })
                        
        var name = pokemon.name
        name = name.prefix(1).uppercased() + name.lowercased().dropFirst()
        nameLabel.text = name
        idLabel.text = "ID: \(pokemon.id)"
            
        var types: String = ""
        var abilities: String = ""
        
        if pokemon.types.count > 1 {
            for item in pokemon.types {
                types += "\(item.type.name), "
            }
        } else {
            types = pokemon.types[0].type.name
        }
            
        if pokemon.abilities.count > 1 {
            for item in pokemon.abilities {
                abilities += "\(item.ability.name), "
            }
        } else {
            abilities = pokemon.abilities[0].ability.name
        }
            
        typesLabel.text = "Types: \(types)"
        abilitiesLabel.text = "Abilities: \(abilities)"
            
        nameLabel.isHidden = false
        imageView.isHidden = false
        typesLabel.isHidden = false
        abilitiesLabel.isHidden = false
        idLabel.isHidden = false
    }

}
