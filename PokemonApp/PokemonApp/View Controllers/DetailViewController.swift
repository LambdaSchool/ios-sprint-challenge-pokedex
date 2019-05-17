//
//  DetailViewController.swift
//  PokemonApp
//
//  Created by Diante Lewis-Jolley on 5/17/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /*guard let pokemon = pokemon else { return }

        pokemonController?.fetchImages(pokemon: pokemon, completion: { (image, error) in
            if let error = error {
                NSLog("Error getting images: \(error)")
                return
            }

            DispatchQueue.main.async {
                self.pokemonImage.image = image
            }
        })
 */


    }

    private func updateViews() {

        guard let pokemon = pokemon else { return }

        idLabel.text = "ID: \(pokemon.id)"
        typeLabel.text = "Type: \(pokemon.types.map{$0.type.name})"
        abilityLabel.text = "Abilities: \(pokemon.abilities.map{$0.ability.name})"

    }






    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    

}
