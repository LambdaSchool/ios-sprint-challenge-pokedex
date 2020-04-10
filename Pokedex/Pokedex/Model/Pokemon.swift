//
//  Pokemon.swift
//  Pokedex
//
//  Created by Harmony Radley on 4/10/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let types: String
    let abilities: [String]
    
    enum PokemonKeys: String, CodingKey {
            case name
            case abilities
            
            enum AbilityContentKeys: String, CodingKey {
                case ability
                
                enum AbilityNameKeys: String, CodingKey {
                    case name
                }
            }
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: PokemonKeys.self)
            name = try container.decode(String.self, forKey:  .name)
            
            var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
            var abilityNames: [String] = []
            while !abilitiesContainer.isAtEnd {
                let abilityContentContainer = try abilitiesContainer.nestedContainer(keyedBy: PokemonKeys.AbilityContentKeys.self)
                let abilityNameContainer = try abilityContentContainer.nestedContainer(keyedBy: PokemonKeys.AbilityContentKeys.AbilityNameKeys.self, forKey: .ability)
                let abilityName = try abilityNameContainer.decode(String.self, forKey: .name)
                abilityNames.append(abilityName)
            }
            abilities = abilityNames
        }
    }

    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/ditto")!
    let data = try! Data(contentsOf: baseURL)
    let pokemon = try! JSONDecoder().decode(Pokemon.self, from: data)


