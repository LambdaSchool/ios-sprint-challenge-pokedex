//
//  PokemonDetailViewController.swift
//  Okemon
//
//  Created by Jonathan Ferrer on 5/17/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    var pokemonController: PokemonController?
    
    var pokemon: Pokemon?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

     func updateViews() {
        DispatchQueue.main.async {


            if let pokemon = self.pokemon {

                self.nameLabel.text = pokemon.name
                self.idLabel.text = String(pokemon.id)
               

            for ability in pokemon.abilities {
                self.abilitiesLabel.text?.append(contentsOf: ability.ability.name)
                self.abilitiesLabel.text?.append(contentsOf: ", ")
            }

            for type in pokemon.types {
                self.typesLabel.text?.append(contentsOf: type.type.name)
                self.typesLabel.text?.append(contentsOf: ", ")
            }


            self.navigationItem.title = pokemon.name

                self.pokemonController?.getImage(image: pokemon.sprites.frontDefault, completion: { (image, error) in
                    if let error = error {
                        NSLog("Error \(error)")
                        return
                    }
                    guard let image = image else {
                        NSLog("Error fetching image")
                        return
                    }
                    pokemon.imageData = image.pngData()
                    if let pokemonImage = pokemon.imageData {
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: pokemonImage)
                        }
                    }
                })


        }
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }




}
