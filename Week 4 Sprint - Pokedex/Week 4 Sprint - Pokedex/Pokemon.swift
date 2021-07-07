
import UIKit

struct Pokemon: Codable {
    var name: String
    var id: Int
    var types: [types]
    
    struct types: Codable {
        // constant for the second type
        let type: [type]
        
        struct type: Codable {
            // constant for the name
            let name: String
        }
    }
    
    var abilities: [Abilities]
    
    struct Abilities: Codable {
        let ability: [ability]
        
        // represents the final {} ability that holds the key, value that we need
        struct ability: Codable {
            let name: String
        }
    }
    
    
    var sprites: [sprites]
    
    struct sprites: Codable {
        let frontDefault: URL // change from snake_case later
    }

    init(name: String, id: Int, types: [types], abilities: [Abilities], sprites: [sprites]) {
        self.name = name
        self.id = id
        self.types = types
        self.abilities = abilities
        self.sprites = sprites
    }

    
    // Object representing JSON at the highest level
    struct PokemonSearchResults: Codable {
        let results: [Pokemon]


    }
}
