//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Paul Yi on 2/1/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    var pokemon: Pokemon?
    var pokemonController: PokemonController?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let pokemon = pokemon else { return }
        
        nameLabel.text = pokemon.name
        idLabel.text = String(pokemon.id)
        abilitiesLabel.text = pokemon.abilities[0].ability.name
        typeLabel.text = pokemon.types[0].type.name
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
