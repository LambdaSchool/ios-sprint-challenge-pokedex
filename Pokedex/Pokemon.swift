import UIKit

struct Pokemon: Codable {
    
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [Types]
    
    
    struct Ability: Codable {
        let ability: AbilityName
        
        struct AbilityName: Codable {
            let name: String
        }
    }
    
    struct Types: Codable {
        let types: TypesName
        
        struct TypesName: Codable {
            let name: String
        }
    }
}
