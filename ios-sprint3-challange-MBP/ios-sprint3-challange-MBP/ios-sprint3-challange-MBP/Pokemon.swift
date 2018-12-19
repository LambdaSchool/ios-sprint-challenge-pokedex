import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let weight: Int
    let abilities: [Ability]
    let types: [PokemonType]
    let sprites: ImageURLs?
    
    struct ImageURLs: Codable {
        let frontDefault: String?
    }
    
    struct Ability: Codable{
        let ability: SubAbility
        
        struct SubAbility: Codable {
            let name: String
        }
    }
    
    struct PokemonType: Codable {
        let type: SubPokemonType
        
        struct SubPokemonType: Codable {
            let name: String
        }
    }
   
}



