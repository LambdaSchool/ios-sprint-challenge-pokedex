import Foundation

struct PokemonSearchResults: Codable {
    let abilities: [Pokemon.Ability]
    let id: Int
    let name: String
    let sprites: Pokemon.Sprites
    let types: [Pokemon.TypeElement]
    
}

struct Pokemon: Codable {
    let abilities: [Ability]
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    
//    init(name: String, id: Int, types: [TypeElement], abilities: [Ability], sprites: Sprites) {
//        self.name = name
//        self.id = id
//        self.types = types
//        self.abilities = abilities
//        self.sprites = sprites
//    }
    
    struct Ability: Codable {
        let ability: Type
        //let isHidden: Bool
        let slot: Int
        
        enum CodingKeys: String, CodingKey {
            case ability
            //case isHidden = "is_hidden"
            case slot
        }
    }
    
    struct `Type`: Codable {
        let name: String
        let url: String
    }
    
    struct Sprites: Codable {
        //let backDefault, backShiny: String
        let frontDefault: String
        //let frontShiny: String
        
        enum CodingKeys: String, CodingKey {
            //case backDefault = "back_default"
            //case backShiny = "back_shiny"
            case frontDefault //= "front_default"
            //case frontShiny = "frontShiny"
        }
    }
    
    struct TypeElement: Codable {
        let slot: Int
        let type: Type
    }
}
