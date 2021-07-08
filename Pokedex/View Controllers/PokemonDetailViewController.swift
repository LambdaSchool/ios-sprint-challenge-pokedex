//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Welinkton on 9/21/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemonController: PokemonController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
    }

   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var pokemonSprite: UIImageView!
    

    private func updateViews() {
        //guard let pokemon = pokemonController?.pokedex[(path.row)] else {return}

        guard let pokemon = pokemon else { return }

        guard let imageURL = URL(string: pokemon.sprites.frontDefault ) else {return}
        
        do {
            let imageData = try Data(contentsOf: imageURL)
            pokemonSprite.image = UIImage(data: imageData)
        } catch {
            NSLog("Could not use ImageData: \(error)")
            return
        }
        
        
        title = pokemon.name
        print(title)

        let abilities = pokemon.abilities.map {$0.ability.name}.joined(separator: ",")
        let type = pokemon.types.map {$0.type.name}.joined(separator: ",")

        print(abilities)
        
        nameLabel.text = pokemon.name
        idLabel.text = "id: \(pokemon.id)"
        typeLabel.text = "types: \(type)"
        abilitiesLabel.text = "abilities: \(abilities)"

    }

    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }

}
