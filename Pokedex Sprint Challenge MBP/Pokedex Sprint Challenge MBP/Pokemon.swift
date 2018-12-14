
// Documentation: https://pokeapi.co/docs/v2.html/#pokemon
// Base URL: https://pokeapi.co/api/v2/pokemon/{id or name}/

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let types: [Types]
    let abilities: [Abilities]
    let sprites: Sprites
    
    struct Types: Codable {
        let type: type
        
        struct type: Codable {
            let name: String
        }
    }
    
    struct Abilities: Codable {
        let ability: Ability
        
        struct Ability: Codable {
            let name: String
        }
    }
    
    struct Sprites: Codable {
        let frontFemale: String // Change from Snake Case
    }
    
}

/*
struct PokemonSearchResults: Codable {
    let name: [Pokemon.]
    let id: [Pokemon.]
    let types: [Pokemon.Types]
    let
}
 */

/*
struct TopLevelSearchResults: Codable {
    let results: [Pokemon]
}
 */
