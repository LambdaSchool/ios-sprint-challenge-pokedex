import Foundation

struct AllPokemon: Codable {
    var allPokemon: [Pokemon]
}

struct Pokemon: Codable, Equatable {
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.baseExperience == rhs.baseExperience && lhs.height == rhs.height && lhs.id == rhs.id && lhs.isDefault == rhs.isDefault && lhs.locationAreaEncounters == rhs.locationAreaEncounters && lhs.name == rhs.name && lhs.order == rhs.order && lhs.weight == rhs.weight
    }
    
    let abilities: [Ability]
    let baseExperience: Int
    let forms: [Species]
    let gameIndices: [GameIndex]
    let height: Int
    let heldItems: [HeldItem]
    let id: Int
    let isDefault: Bool
    let locationAreaEncounters: String
    let moves: [Move]
    let name: String
    let order: Int
    let species: Species
    let sprites: Sprites
    let stats: [Stat]
    let types: [TypeElement]
    let weight: Int
    
    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case forms
        case gameIndices = "game_indices"
        case height
        case heldItems = "held_items"
        case id
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case moves, name, order, species, sprites, stats, types, weight
    }
}



struct Ability: Codable {
    let ability: Species
    let isHidden: Bool
    let slot: Int
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct Species: Codable {
    let name: String
    let url: String
}

struct GameIndex: Codable {
    let gameIndex: Int
    let version: Species
    
    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}

struct HeldItem: Codable {
    let item: Species
    let versionDetails: [VersionDetail]
    
    enum CodingKeys: String, CodingKey {
        case item
        case versionDetails = "version_details"
    }
}

struct VersionDetail: Codable {
    let rarity: Int
    let version: Species
}

struct Move: Codable {
    let move: Species
    let versionGroupDetails: [VersionGroupDetail]
    
    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

struct VersionGroupDetail: Codable {
    let levelLearnedAt: Int
    let moveLearnMethod, versionGroup: Species
    
    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}

struct Sprites: Codable {
    let backDefault, backFemale, backShiny, backShinyFemale: String
    let frontDefault, frontFemale, frontShiny, frontShinyFemale: String
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

struct Stat: Codable {
    let baseStat, effort: Int
    let stat: Species
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

struct TypeElement: Codable {
    let slot: Int
    let type: Species
}
