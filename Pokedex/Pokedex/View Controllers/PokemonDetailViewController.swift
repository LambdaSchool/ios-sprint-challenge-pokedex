//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Linh Bouniol on 8/10/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemonController: PokemonController? 
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var abilityLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }

    func updateViews() {
        guard let pokemon = pokemon else { return }
      
        self.title = pokemon.name.capitalized
        self.nameLabel?.text = "Name: \(pokemon.name.capitalized)"
        self.idLabel?.text = "ID: \(String(pokemon.id))"
        self.abilityLabel?.text = "Abilities: \(pokemon.abilities.joined(separator: ", "))" // join all the strings of the array
        self.typeLabel?.text = "Types: \(pokemon.types.joined(separator: ", "))"
        
        if let imageURLString = pokemon.sprites["front_default"] as? String, let URL = URL(string: imageURLString) {
            self.pokemonController?.fetchImage(url: URL, completion: { (image, error) in
                if let image = image {
                    self.imageView.image = image
                }
            })
        }
    }
}
