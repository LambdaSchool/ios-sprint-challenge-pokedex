import Foundation
struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [Abilities]
    let types: [Types]
    let sprites: Sprites?

    struct Types: Codable {
        let type: Name
    }
    
    struct Abilities: Codable {
        let ability: Name
    }
    
    struct Name: Codable {
        let name: String
    }
    
    struct Sprites: Codable {
        let frontDefault: String?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}

//struct PokemonSearchResults: Codable {
//    let results: [Pokemon]
//}
