//
//  PokemonDetailViewController.swift
//  Pokemon
//
//  Created by Cody Morley on 5/8/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import UIKit
import Foundation

class PokemonDetailViewController: UIViewController {
    //MARK: - Properties -
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemon: Pokemon?
    
    
    //MARK: - Life Cycles -
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
    //MARK: - Methods -
    func updateViews() {
        guard let pokemon = pokemon else { return }
        print(pokemon)
        
        nameLabel.text = pokemon.name
        idLabel.text = String("ID#: \(pokemon.id)")
        
        let imageURLString = pokemon.sprites.front_default
        guard let imageURL = URL(string: imageURLString) else { return }
        do {
            let imageData = try Data(contentsOf: imageURL)
            let image = UIImage(data: imageData)
            imageView.image = image
        } catch {
            print("error loading image \(error) \(error.localizedDescription)")
        }
        
        var typeNames: [String] = []
        for type in pokemon.types {
            typeNames.append(type.type.name)
        }
        let typesString = typeNames.joined(separator: ", ")
        typesLabel.text = "Types: \(typesString)"
        
        var abilityNames: [String] = []
        for ability in pokemon.abilities {
            abilityNames.append(ability.ability.name)
        }
        let abilitiesString = abilityNames.joined(separator: ", ")
        abilitiesLabel.text = "Abilities: \(abilitiesString)"
    }
}
