import Foundation

//struct PokemonSearchResults: Codable {
//    let abilities: [Pokemon.Ability]
//    let id: Int
//    let name: String
//    let sprites: Pokemon.Sprites
//    let types: [Pokemon.TypeElement]
//}

struct Pokemon: Codable, Equatable {
    let abilities: [Ability]
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
        
    struct Ability: Codable, Equatable {
        let ability: Type
        let slot: Int
        
        enum CodingKeys: String, CodingKey {
            case ability
            case slot
        }
        
        static func == (lhs: Pokemon.Ability, rhs: Pokemon.Ability) -> Bool {
            return
                lhs.ability == rhs.ability &&
                lhs.slot == rhs.slot
        }
        
    }
    struct `Type`: Codable, Equatable {
        let name: String
        let url: String
        
        static func == (lhs: Pokemon.`Type`, rhs: Pokemon.`Type`) -> Bool {
            return
                lhs.name == rhs.name &&
                lhs.url == rhs.url
        }
    }
    struct Sprites: Codable {
        let frontDefault: String
        
        enum CodingKeys: String, CodingKey {
            case frontDefault
        }
    }
    struct TypeElement: Codable, Equatable {
        let slot: Int
        let type: Type
        
        
    }
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return
            lhs.abilities == rhs.abilities &&
            lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.types == rhs.types
        
    }
    
}
