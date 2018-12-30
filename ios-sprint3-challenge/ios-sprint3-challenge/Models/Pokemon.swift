import Foundation
import UIKit

struct Pokemon: Codable, Equatable {
    
    let abilities: [Ability]?
    let id: Int?
    let name: String?
    let species: Species?
    let sprites: Sprites?
    let types: [TypeElement]?
    
    enum CodingKeys: String, CodingKey {
        case abilities
        case id
        case name, species, sprites, types
    }
    
    static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.abilities == rhs.abilities && lhs.id == rhs.id && lhs.name == rhs.name && lhs.species == rhs.species && lhs.sprites == rhs.sprites && lhs.types == rhs.types
    }
}

struct Ability: Codable, Equatable {
    static func ==(lhs: Ability, rhs: Ability) -> Bool {
        return lhs.ability == rhs.ability
    }
    
    let ability: Species?
    //let isHidden: Bool?
    //let slot: Int?
    
    enum CodingKeys: String, CodingKey {
        case ability
        //case isHidden = "is_hidden"
        //case slot
    }
}

struct Species: Codable, Equatable {
    let name: String?
    let url: String?
}


struct Sprites: Codable, Equatable {
    //let backDefault, backFemale, backShiny, backShinyFemale: String?
    //let frontDefault, frontFemale, frontShiny, frontShinyFemale: String?
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        //case backDefault = "back_default"
        //case backFemale = "back_female"
        //case backShiny = "back_shiny"
        //case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        //case frontFemale = "front_female"
        //case frontShiny = "front_shiny"
        //case frontShinyFemale = "front_shiny_female"
    }
}

struct TypeElement: Codable, Equatable {
    //let slot: Int?
    let type: Species?
}

