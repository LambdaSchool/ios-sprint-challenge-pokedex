//
//  Pokedex.swift
//  Pokedex
//
//  Created by alfredo on 1/26/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import Foundation

struct PokedexEntry: Codable{
    var abilities: [Ability]
    var favorite: Bool = false
    var height: Int
    var id: Int
    var images: Sprites
    let name: String
    var species: PokemonNameAndURL
    var types: [Type]
    let url: URL!
    var weight: Int
    
    func getAbilitiesAsString() -> String{
        var abilitiesArray: [String] = []
        
        for ability in abilities {
            abilitiesArray.append(ability.ability.name)
        }
        return abilitiesArray.joined(separator: ", ")
    }
    func getTypesString() -> String{
        var typesArray: [String] = []
        for type in types{
            typesArray.append(type.type.name)
        }
        return typesArray
            .joined(separator: ", ")
    }
}
