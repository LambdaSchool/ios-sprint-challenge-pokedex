//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Sammy Alvarado on 7/20/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!


    var apiController: APIController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }

    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemon = pokemon else { return }


        title = pokemon.name.capitalized
        guard let pokemonImageData = try? Data(contentsOf: pokemon.sprites) else {return}
        imageLabel.image = UIImage(data: pokemonImageData)
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(String(pokemon.id))"

        var types = " "
        let typeArray = pokemon.types
        for type in typeArray {
            types.append(type.capitalized)
        }
        typesLabel.text = "Types: \(types)"

        var abilities = " "
        let abilityArray = pokemon.abilities
        for ability in abilityArray {
            abilities.append(ability.capitalized)
        }
        abilitiesLabel.text = "Abilities: \(abilities)"
    }
}

