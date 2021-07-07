
// Documentation: https://pokeapi.co/docs/v2.html/#pokemon
// Base URL: https://pokeapi.co/api/v2/pokemon/{id or name}/

import Foundation

struct Pokemon: Codable {
    
    let name: String
    let id: Int
    let types: [TypeElement]
    let abilities: [Ability]
    let sprites: Sprites

}

struct TypeElement: Codable {
    let type: Species
}

struct Ability: Codable {
    let ability: Species
}

struct Species: Codable {
    let name: String
}

struct Sprites: Codable {
    let frontDefault: String // convert from snake case
}


/*
struct PokemonSearchResults: Codable {
    let results: [Pokemon]
}
*/

/*
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
        let frontDefault: String // Change from Snake Case
    }
    
}

struct PokemonSearchResults: Codable {
    let JSON: [Pokemon]
    
    //let name: String
    //let id: Int
    //let types: [Pokemon.Types]
    //let abilities: [Pokemon.Abilities]
    //let sprites: Pokemon.Sprites
    
}






//struct TopLevelSearchResults: Codable {
    //let results: [Pokemon]
//}

*/
