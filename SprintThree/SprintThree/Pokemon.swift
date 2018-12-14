import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [Abilities]
    
    struct Abilities: Codable {
        let ability: [ability]
        
        struct ability: Codable {
            let name: String
        }
    }
    let types: [Types]
    struct Types: Codable {
        let type: [type]
        
        struct type: Codable {
            let name: String
        }
    }
    let sprites: ImageURLs
    struct ImageURLs: Codable {
        let frontDefault: String
    }
}

struct SearchResults: Codable {
    let pokemon: [Pokemon]
    let types: [Pokemon.Types]
    let abilities: [Pokemon.Abilities]
    let sprites: Pokemon.ImageURLs
}
