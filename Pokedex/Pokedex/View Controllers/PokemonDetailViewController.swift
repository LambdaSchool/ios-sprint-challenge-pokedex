//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Scott Bennett on 12/20/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        title = pokemon.name.capitalized
        
        let abilityString = pokemon.abilities.map { $0.ability.name }.joined(separator: ", ")
        let typeString = pokemon.types.map { $0.type.name }.joined(separator: ", ")
        
        idLabel.text = "ID:  \(pokemon.id)"
        typesLabel.text = "Types:  \(typeString.capitalized)"
        abilitiesLabel.text = "Abilities:  \(abilityString.capitalized)"
        
        // Get image
        guard let imageURL = URL(string: pokemon.sprites.front_default) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if error == nil {
                let loadedImage = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.imageView.image = loadedImage
                }
                
            }
        }.resume()        
    }
}
