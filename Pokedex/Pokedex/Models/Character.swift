//
//  Character.swift
//  Pokedex
//
//  Created by morse on 5/10/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation

//struct Character {
//    let abilities: [String]
//    let id: Int
//    let name: String
//    let types: [String]
//    let sprites: String
//}

struct Character: Codable {
    let abilities: [AbilityDescription]
    let id: Int
    let name: String
    let types: [TypeDescription]
    let sprites: Sprite
}



struct AbilityDescription: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}

struct TypeDescription: Codable {
    let type: TypeName
}

struct TypeName: Codable {
    let name: String
}

struct Sprite: Codable {
    let front_default: String
}

enum CodingKeys: String, CodingKey {
    case frontDefault = "front_default"
}


//struct Character: Codable {
//    let abilities: [AbilityElement]
//    let id: Int
//    let name: String
//    let sprites: Sprites
//    let types: [TypeElement]
//}
//
//
//
//
//struct TypeClass: Codable {
//    let name: String
//}
//
//struct AbilityElement: Codable {
//    let ability: TypeClass
//}
//
//struct Sprites: Codable {
//    let frontDefault: String
//
//    enum CodingKeys: String, CodingKey {
//        case frontDefault = "front_default"
//    }
//}
//
//struct TypeElement: Codable {
//    let type: TypeClass
//}




//struct Character: Codable {
//    let name: String
//    let id: Int
//    let types: [String]
//    let abilities: [AbilityEle]
//
//
//
//
//
//
//
//    struct Kind: Codable {
//        let
//    }
//
//
//
//
//    struct Ability: Codable, Equatable {
//        let name: String
//    }
//}
//
//fileprivate struct RawServerResponse: Decodable {
//    struct User: Decodable {
//        var user_name: String
//        var real_info: UserRealInfo
//    }
//
//    struct UserRealInfo: Decodable {
//        var full_name: String
//    }
//
//    struct Review: Decodable {
//        var count: Int
//    }
//
//    var id: Int
//    var user: User
//    var reviews_count: [Review]
//}
//
//struct ServerResponse: Decodable {
//    var id: String
//    var username: String
//    var fullName: String
//    var reviewCount: Int
//
//    init(from decoder: Decoder) throws {
//        let rawResponse = try RawServerResponse(from: decoder)
//
//        // Now you can pick items that are important to your data model,
//        // conveniently decoded into a Swift structure
//        id = String(rawResponse.id)
//        username = rawResponse.user.user_name
//        fullName = rawResponse.user.real_info.full_name
//        reviewCount = rawResponse.reviews_count.first!.count
//    }
//}
//
//
//struct CharacterSearch: Codable {
//    let results: [Character]
//}
//
