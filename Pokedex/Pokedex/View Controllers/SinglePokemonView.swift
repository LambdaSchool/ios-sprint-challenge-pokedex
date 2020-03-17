//
//  SinglePokemonView.swift
//  Pokedex
//
//  Created by Lotanna Igwe-Odunze on 11/2/18.
//  Copyright © 2018 Lotanna. All rights reserved.
//

import Foundation
import UIKit

class SinglePokemonView: UIViewController {
    
    //Outlets
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var pokeID: UILabel!
    @IBOutlet weak var pokePhoto: UIImageView!
    @IBOutlet weak var pokeAbility: UILabel!
    @IBOutlet weak var pokeType: UILabel!
    
    //Properties
    
    var myPokemon: Pokemon?
    
    func displayPokemon() {
        
        pokeName.text = myPokemon?.name
        pokeID.text = "\(String(describing: myPokemon?.id))"
        //pokePhoto.image =
        pokeAbility.text = myPokemon?.abilities.first?.ability.name
        pokeType.text = myPokemon?.types.first?.pokemonType.name
        
        
        
    }
    
    
}
