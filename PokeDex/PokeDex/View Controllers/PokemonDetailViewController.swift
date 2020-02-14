//
//  PokemonDetailViewController.swift
//  PokeDex
//
//  Created by Enrique Gongora on 2/14/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    
    //MARK: - Variables
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
        if let pokemon = pokemon {
            updateDetails(with: pokemon)
        }
    }
    
    func updateDetails(with pokemon: Pokemon) {
        pokemonController?.fetchImage(with: pokemon.sprites.defaultImageURL, completion: { (result) in
            do {
                let pokemonImage = try result.get()
                self.updateImage(with: pokemonImage)
            } catch {
                self.imageView.image = nil
            }
        })
        
        // Needed to cycle through the abilities
        let pokemonDetail = pokemon
        var types: [String] = []
        for typeInfo in pokemonDetail.types {
            types.append(typeInfo.type.name)
        }
        
        // Has to be loaded on the main thread
        DispatchQueue.main.async {
            self.pokemonNameLabel.text = pokemon.name.capitalized
            self.idLabel.text = "ID: \(pokemon.id)"
            self.typeLabel.text = "Types: \(types.joined(separator: ", ").capitalized)"
            self.abilityLabel.text = "Abilities: \(pokemon.abilities[0].ability.name.capitalized)"
        }
    }
    
    // Will be called in updateDetails function to update the image of the Pokemon
    func updateImage(with image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
