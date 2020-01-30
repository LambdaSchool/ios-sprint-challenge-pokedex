import Foundation

struct Pokemon: Codable {
    let abilities: [Ability]
    let types: [Type]
    let id: Int
    let name: String
    let sprites: Image
}

struct Ability: Codable {
    let ability: nameConvention
}

struct Type: Codable {
    let type: nameConvention
}

struct Image: Codable {
    let front_default: String
}

struct nameConvention: Codable {
    let name: String
}
