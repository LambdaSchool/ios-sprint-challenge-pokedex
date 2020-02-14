//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by scott harris on 2/14/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var pokemon: Pokemon?
    var pokemonController: PokemonController?
    var isButtonHidden = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        nameLabel.text = pokemon.name
        idLabel.text = "\(pokemon.id)"
        var typesString = ""
        for type in pokemon.types {
            typesString += type.type.name + " "
        }
        typesLabel.text = typesString
        var abilityString = ""
        for ability in pokemon.abilities {
            abilityString += ability.ability.name + " "
        }
        abilitiesLabel.text = abilityString
        
        saveButton.isHidden = isButtonHidden
        
        fetchImageViewImage()
        
    }
    
    func fetchImageViewImage() {
        guard let pokemon = pokemon,
        let pokemonController = pokemonController else { return }
        
        pokemonController.fetchImage(at: pokemon.sprite.frontDefault) { (result) in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
                
            }
        }
        
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let pokemonController = pokemonController,
           let pokemon = pokemon else { return }
        pokemonController.pokemen.append(pokemon)
        navigationController?.popViewController(animated: true)
        
    }
    
    
}
