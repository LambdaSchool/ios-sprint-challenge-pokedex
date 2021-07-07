//
//  PokemonDetailViewController.swift
//  Podex II
//
//  Created by Ivan Caldwell on 12/14/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // Variables and Constants
    var pokemon: Pokemon?
    
    // Outlets and Actions
    @IBOutlet weak var pokemonNameTitle: UINavigationItem!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilityLabel: UILabel!
    
    // Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var index = 0
        var abilities: String = "Ability: "
        while index < pokemon?.abilities.count ?? 0 {
            abilities += " \(pokemon!.abilities[index].ability.name),"
            index += 1
        }
        abilities.removeLast()
        index = 0
        var types: String = "Type: "
        while index < pokemon!.types.count {
            types += " \(pokemon!.types[index].type.name),"
            index += 1
        }
        types.removeLast()
        let imageURL = URL(string: (self.pokemon?.sprites?.frontDefault)!)
        let imageData = try! Data(contentsOf: imageURL!)
        pokemonNameTitle.title = pokemon!.name
        pokemonIDLabel.text = "ID: \(pokemon!.id)"
        pokemonTypeLabel.text = types
        pokemonAbilityLabel.text = abilities
        pokemonImage.image = UIImage(data: imageData)
    }
}
