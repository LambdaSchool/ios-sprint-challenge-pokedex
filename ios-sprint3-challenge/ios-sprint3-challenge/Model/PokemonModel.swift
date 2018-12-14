import Foundation

struct PokemonModel: Codable {
    var name: String
    var id: Int
    var abilities: [PokemonAbility]
    var types: [PokemonType]
    var sprites: [String : String?]
    
    struct PokemonAbility: Codable {
        var ability: [String : String]

        }
    struct PokemonType: Codable {
        var type: [String : String]

        }
}
