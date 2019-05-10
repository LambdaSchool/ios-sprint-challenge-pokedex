//
//  DetailViewController.swift
//  PokemonApp
//
//  Created by Diante Lewis-Jolley on 5/10/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       updateViews()
    }



    private func updateViews() {
        guard let pokemon = pokemon else { return }

        idLabel.text = "\(pokemon.id)"

        let convertedTypeString = pokemon.types.map { $0.name}
        typeLabel.text = "\(convertedTypeString)"

        let convertedAbilityString = pokemon.abilities.map {$0.name}
        abilityLabel.text = "\(convertedAbilityString)"

        guard let imageData = pokemon.imageData else { return }
        pokemonImage.image = UIImage(data: imageData)

    }

    

    



    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }

    var pokemonController: PokemonController?

    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!



}
