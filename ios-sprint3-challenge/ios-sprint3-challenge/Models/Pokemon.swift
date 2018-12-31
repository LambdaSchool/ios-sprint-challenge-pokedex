import Foundation
import UIKit

class Pokemon: Codable, Equatable, FirebaseItem {
    lazy var recordIdentifier: String = ""  // lazy var "hack" to keep JSONDecoder from throwing errors
    
    
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
        //case recordIdentifier
    }
    
    static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.abilities == rhs.abilities && lhs.id == rhs.id && lhs.name == rhs.name && lhs.species == rhs.species && lhs.sprites == rhs.sprites && lhs.types == rhs.types
    }
}

class Ability: Codable, Equatable, FirebaseItem {
    lazy var recordIdentifier: String = ""
    
    static func ==(lhs: Ability, rhs: Ability) -> Bool {
        return lhs.ability == rhs.ability
    }
    
    let ability: Species?
    //let isHidden: Bool?
    //let slot: Int?
    
    enum CodingKeys: String, CodingKey {
        case ability
        //case recordIdentifier
        //case isHidden = "is_hidden"
        //case slot
    }
}

class Species: Codable, Equatable, FirebaseItem {
    static func == (lhs: Species, rhs: Species) -> Bool {
        return lhs.name == rhs.name && lhs.url == rhs.url
    }
    
    lazy var recordIdentifier: String = ""
    
    let name: String?
    let url: String?
}


class Sprites: Codable, Equatable, FirebaseItem {
    static func == (lhs: Sprites, rhs: Sprites) -> Bool {
        return lhs.frontDefault == rhs.frontDefault
    }
    
    lazy var recordIdentifier: String = ""
    
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
        //case recordIdentifier
    }
}

class TypeElement: Codable, Equatable, FirebaseItem {
    static func == (lhs: TypeElement, rhs: TypeElement) -> Bool {
        return lhs.type?.name == rhs.type?.name
    }
    
    lazy var recordIdentifier: String = ""
    
    //let slot: Int?
    let type: Species?
}

