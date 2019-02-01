import Foundation

struct Pokemon: Codable {  // , Equatable {
    
    var name: String
    var abilites: [Ability]
    var id: Int
    var image: Sprites
    var types: [TypeElement]
    
    
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

struct TypeElement: Codable {
    let type: Species
}
