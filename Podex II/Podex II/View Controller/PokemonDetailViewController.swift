//
//  PokemonDetailViewController.swift
//  Podex II
//
//  Created by Ivan Caldwell on 12/14/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//
/*
   I am being a lazy programmer by force unwrapping everything. I should go back and use guard
   statements and should create a function to create the string for pokemon type and abilities, but
   I want MVP... sooooo.... that will be something that i will change if time permits.
 */
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
            print (pokemon!.abilities[index].ability.name)
            abilities += " \(pokemon!.abilities[index].ability.name),"
            index += 1
        }
        abilities.removeLast()
        index = 0
        var types: String = "Type: "
        print ("Type Count: \(pokemon!.types.count)")
        while index < pokemon!.types.count {
            print (pokemon!.types[index].type.name)
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
