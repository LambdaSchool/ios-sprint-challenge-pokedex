import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [PokemonType]
    
    struct Ability: Codable,  Equatable {
        let ability: SubAbility
        
        struct SubAbility: Codable, Equatable {
            let name: String
        }
    }
    
    struct PokemonType: Codable, Equatable {
        let type: SubPokemonType
        
        struct SubPokemonType: Codable, Equatable {
            let name: String
        }
    }
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case abilities = "abilities"
        case types = "types"
    }
}


struct PokemonSearchResult: Codable, Equatable {
    let results: [Pokemon]
}
