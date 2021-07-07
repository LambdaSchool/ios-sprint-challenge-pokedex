//
//  Pokemon.swift
//  Pokedex
//
//  Created by Paul Yi on 2/1/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import Foundation

class Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [PokemonType]
    let sprites: Sprites
    var imageData: Data?
    
    var abilityString: String {
        let abilitiesStrings = abilities.map { $0.ability.name }
        return abilitiesStrings.joined(separator: ", ")
    }
    
    var typesString: String {
        let typesStrings = types.map { $0.type.name }
        return typesStrings.joined(separator: ", ")
    }
    
    struct Ability: Codable, Equatable {
        let ability: SubAbility
        
        struct SubAbility: Codable, Equatable {
            let name: String
        }
    }
    
    struct PokemonType: Codable, Equatable {
        let type: SubPokemonType
        
        struct SubPokemonType: Codable, Equatable {
            let name: String
        }
    }
    
    // MARK: - Equatable
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
    struct Sprites: Codable, Equatable {
        let frontDefault: String
    }

}
