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
    let frontDefault: String
}

