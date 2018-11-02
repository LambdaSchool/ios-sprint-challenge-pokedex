import UIKit

struct Pokemon: Codable, Equatable {
    
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [Types]
    
    struct Ability: Codable, Equatable {
        let ability: AbilityName
        
        struct AbilityName: Codable, Equatable {
            let name: String
        }
    }
    
    struct Types: Codable, Equatable {
        let type: TypesName
        
        struct TypesName: Codable, Equatable {
            let name: String
        }
    }
}

