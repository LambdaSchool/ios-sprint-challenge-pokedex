import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let type: [Type]
}

struct Ability: Codable, Equatable {
    let name: String
    let id: Int
}

struct Type: Codable, Equatable {
    let name: String
    let id: Int
}
