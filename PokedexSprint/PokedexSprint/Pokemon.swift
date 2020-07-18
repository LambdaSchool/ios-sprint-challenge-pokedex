//
//  Pokemon.swift
//  PokedexSprint
//
//  Created by John McCants on 7/17/20.
//  Copyright © 2020 John McCants. All rights reserved.
//

import Foundation
import UIKit

struct PokemonSearchResult: Codable {
    
    let name: String
    let abilities: [String]
    
    //Coding Keys
    enum Keys: String, CodingKey {
        case species
        case name
        case abilities
                
        enum AbilityDescriptionKeys: String, CodingKey {
            case ability
            
            enum AbilityKeys: String, CodingKey {
                case name
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        name = try container.decode(String.self, forKey: .name)
        
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        
        var abilityNames: [String] = []
        
        while abilitiesContainer.isAtEnd == false {
            // abilitiesContainer points to the "n"th item in the array
            
            let abilityDescriptionContainer = try abilitiesContainer.nestedContainer(keyedBy: Keys.AbilityDescriptionKeys.self)
            
            let abilityContainer = try abilityDescriptionContainer.nestedContainer(keyedBy: Keys.AbilityDescriptionKeys.AbilityKeys.self, forKey: .ability)
            
            let abilityName = try abilityContainer.decode(String.self, forKey: .name)
            abilityNames.append(abilityName)
        }
        
        abilities = abilityNames
    }
    
    //Helper Method for the Abilities Label
    func getAbilitiesString() -> String{
        var string = "Abilities:"
        for ability in self.abilities {
            if ability == self.abilities.last || ability == self.abilities.first {
                string += "\(ability)"
            }
            string += ",\(ability)"
        }
        
        return string
    }

}

struct PokemonSearchResults: Codable {
    let results : [PokemonSearchResult]
}

struct Pokemon: Codable {
    let pokemonName : String
}
