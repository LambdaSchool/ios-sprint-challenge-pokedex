import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [Abilities]
    
    struct Abilities: Codable {
        let ability: [Ability]
        
        struct Ability: Codable {
            let name: String
        }
    }
    let types: [Types]
    struct Types: Codable {
        let type: SubType
        
        struct SubType: Codable {
            let name: String
        }
    }
    let sprites: Sprites
    struct Sprites: Codable {
        let frontDefault: String
    }
}

//struct SearchResults: Codable {
//    let pokemon: [Pokemon]
//    let types: [Pokemon.Types]
//    let abilities: [Pokemon.Abilities]
//    let sprites: Pokemon.ImageURLs
//}
