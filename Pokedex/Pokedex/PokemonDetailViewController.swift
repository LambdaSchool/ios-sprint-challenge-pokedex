//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Moin Uddin on 9/14/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        nameDetailLabel.text = pokemon.name
        idDetailLabel.text = "id: " + String(pokemon.id)
        typesDetailLabel.text = "types: " + typesToString(types: pokemon.types)
        abilitiesDetailLabel.text = "abilties: " + abilitiesToString(abilities: pokemon.abilities)
        title = pokemon.name
    }
    
    func typesToString(types: [Pokemon.PokemonType]) -> String {
        var str = ""
        for pokemonType in types {
            str += " \(pokemonType.type.name),"
        }
        return str
    }
    
    func abilitiesToString(abilities: [Pokemon.PokemonAbility]) -> String {
        var str = ""
        for pokemonAbility in abilities {
            str += " \(pokemonAbility.ability.name),"
        }
        return str
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var nameDetailLabel: UILabel!
    @IBOutlet weak var idDetailLabel: UILabel!
    @IBOutlet weak var typesDetailLabel: UILabel!
    @IBOutlet weak var abilitiesDetailLabel: UILabel!
    
    
    
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
