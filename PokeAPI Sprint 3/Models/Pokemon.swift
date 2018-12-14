import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: [Ability]
    let sprites: Sprites
    let types: [TypeElement]
}

struct Ability: Codable {
    let ability: Types
}

// For Ability and TypeElement
struct Types: Codable {
    let name: String
    let url: String
}

struct Sprites: Codable {
    let backDefault: String
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case frontDefault = "front_default"
    }
}

struct TypeElement: Codable {
    let slot: Int
    let type: Types
}
