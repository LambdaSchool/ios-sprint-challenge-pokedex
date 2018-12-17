import Foundation
struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [Types]
    let sprites: Sprites
}

struct Types: Codable {
    let type: Other
}

struct Ability: Codable {
    let ability: Other
}

struct Other: Codable {
    let name: String
}

struct Sprites: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
