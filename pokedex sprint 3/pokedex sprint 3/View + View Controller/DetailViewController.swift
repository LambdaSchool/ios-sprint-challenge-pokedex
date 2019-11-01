//
//  DetailViewController.swift
//  pokedex sprint 3
//
//  Created by Rick Wolter on 11/1/19.
//  Copyright © 2019 Richar Wolter. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

          
          var pokemon: Pokemon?
          var pokemonController: PokemonController?
          
         @IBOutlet weak var nameLabel: UILabel!
         @IBOutlet weak var idLabel: UILabel!
         @IBOutlet weak var typesLabel: UILabel!
         @IBOutlet weak var abilitiesLabel: UILabel!
         @IBOutlet weak var imageView: UIImageView!
    
     override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            updateViews()
        }
    
    private func updateViews() {
           guard let pokemon = pokemon,
               let imageData = pokemon.imageData else { return }
           
           nameLabel.text = pokemon.name
           idLabel.text = "I.D.: \(pokemon.id)"
           
           let typeString = pokemon.type.map {$0.type.name}.joined(separator: "/")
           typesLabel.text = "Types: \(typeString)"
           
           let stringOfAbilities = pokemon.ability.map {$0.ability.name}.joined(separator: ", ")
           abilitiesLabel.text = "Abilities: \(stringOfAbilities)"
           
           imageView.image = UIImage(data: imageData)
       }
        
   
    }
