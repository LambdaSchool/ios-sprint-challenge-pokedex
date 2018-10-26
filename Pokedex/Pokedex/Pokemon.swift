import Foundation

class Pokemon: Codable, Equatable {
    
    let name: String
    let id: Int
    let abilities: [AbilitySlot]
    let types: [TypeSlot]
    let sprites: Sprites
    var imageData: Data?
    
    var abilityString: String {
        let abilitiesStrings = abilities.map { $0.ability.name }
        return abilitiesStrings.joined(separator: ", ")
    }
    
    var typesString: String {
        let typesStrings = types.map { $0.type.name }
        return typesStrings.joined(separator: ", ")
    }
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
}

struct AbilitySlot: Codable, Equatable {
    let ability: Ability
}

struct Ability: Codable, Equatable {
    let name: String
}

struct TypeSlot: Codable, Equatable {
    let type: Type
}

struct Type: Codable, Equatable {
    let name: String
}

struct Sprites: Codable, Equatable {
    let frontDefault: String
}
