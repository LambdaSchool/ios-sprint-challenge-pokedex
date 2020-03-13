//
//  Pokemon.swift
//  Pokedex
//
//  Created by Mark Gerrior on 3/13/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation

struct Generation: Codable {
    var name: String    // generation-iii
    var url: String     // https://pokeapi.co/api/v2/generation/3/
}

struct Language: Codable {
    var name: String    // en
    var url: String     // https://pokeapi.co/api/v2/language/9/
}

struct Names: Codable {
    var name: String    // Stench
    var language: Language
}

struct EffectEntries: Codable {
    var effect: String  // "This Pokémon's damaging moves have a 10% chance to make the target [flinch]{mechanic:flinch} with each hit if they do not already cause flinching as a secondary effect.\n\nThis ability does not stack with a held item.\n\nOverworld: The wild encounter rate is halved while this Pokémon is first in the party.",
    var short_effect: String? // Has a 10% chance of making target Pokémon [flinch]{mechanic:flinch} with each hit.",
    var language: Language
}

struct VersionGroup: Codable {
    var name: String // black-white
    var url: String // https://pokeapi.co/api/v2/version-group/11/
}

struct EffectChanges: Codable {
    var version_group: VersionGroup
    var effect_entries: [EffectEntries]
}

struct FlavorTextEntries: Codable {
    var flavor_text: String // è‡­ãã¦ã€€ç›¸æ‰‹ãŒ\nã²ã‚‹ã‚€ã€€ã“ã¨ãŒã‚ã‚‹ã€‚
    var language: Language
    var version_group: VersionGroup
}

struct PokemonImg: Codable {
    var name: String    // gloom
    var url: String     // https://pokeapi.co/api/v2/pokemon/44/
}

struct PokemonObj: Codable {
    var is_hidden: Bool // true
    var slot: Int // 3
    var pokemon: PokemonImg
}

struct Ability: Codable {

    var id: Int                 // 1
    var name: String            // stench
    var is_main_series: Bool    // true
    
    var generation: Generation
    var names: [Names]

    var effect_entries: [EffectEntries]

    var effect_changes: [EffectChanges]

    var flavor_text_entries: [FlavorTextEntries]

    var pokemon: [PokemonObj]
}

struct Abilities: Codable {
    var is_hidden: Bool // true
    var slot: Int       // 3
//    var ability": {
//      "name": "tinted-lens",
//      "url": "https://pokeapi.co/api/v2/ability/110/"
//    }
}

struct Type : Codable {
    var name: String    // flying
    var url: String     // https://pokeapi.co/api/v2/type/3/
}

struct Types: Codable {
    var slot: Int   // 2
    var type: Type
}

struct Sprites: Codable {
    var back_female: String?        // http://pokeapi.co/media/sprites/pokemon/back/female/12.png
    var back_shiny_female: String?  // http://pokeapi.co/media/sprites/pokemon/back/shiny/female/12.png
    var back_default: String        // http://pokeapi.co/media/sprites/pokemon/back/12.png
    var front_female: String?       // http://pokeapi.co/media/sprites/pokemon/female/12.png
    var front_shiny_female: String? // http://pokeapi.co/media/sprites/pokemon/shiny/female/12.png
    var back_shiny: String          // http://pokeapi.co/media/sprites/pokemon/back/shiny/12.png
    var front_default: String       // http://pokeapi.co/media/sprites/pokemon/12.png
    var front_shiny: String         // http://pokeapi.co/media/sprites/pokemon/shiny/12.png
}

struct Pokemon: Codable {

    var id: Int                 // 12
    var name: String            // butterfree
    var base_experience: Int    // 178
    var height: Int             // 11
    var is_default: Bool        // true
    var order: Int              // 16
    var weight: Int             // 320
    
    var abilities: [Abilities]
    
    var types: [Types]

    var sprites: Sprites

    //  "forms": [
//    {
//      "name": "butterfree",
//      "url": "https://pokeapi.co/api/v2/pokemon-form/12/"
//    }
//  ],
//
//  "game_indices": [
//    {
//      "game_index": 12,
//      "version": {
//        "name": "white-2",
//        "url": "https://pokeapi.co/api/v2/version/22/"
//      }
//    }
//  ],
//
//  "held_items": [
//    {
//      "item": {
//        "name": "silver-powder",
//        "url": "https://pokeapi.co/api/v2/item/199/"
//      },
//      "version_details": [
//        {
//          "rarity": 5,
//          "version": {
//            "name": "y",
//            "url": "https://pokeapi.co/api/v2/version/24/"
//          }
//        }
//      ]
//    }
//  ],
//
//  "location_area_encounters": [
//    {
//      "location_area": {
//        "name": "kanto-route-2-south-towards-viridian-city",
//        "url": "https://pokeapi.co/api/v2/location-area/296/"
//      },
//      "version_details": [
//        {
//          "max_chance": 10,
//          "encounter_details": [
//            {
//              "min_level": 7,
//              "max_level": 7,
//              "condition_values": [
//                {
//                  "name": "time-morning",
//                  "url": "https://pokeapi.co/api/v2/encounter-condition-value/3/"
//                }
//              ],
//              "chance": 5,
//              "method": {
//                "name": "walk",
//                "url": "https://pokeapi.co/api/v2/encounter-method/1/"
//              }
//            }
//          ],
//          "version": {
//            "name": "heartgold",
//            "url": "https://pokeapi.co/api/v2/version/15/"
//          }
//        }
//      ]
//    }
//  ],
//
//  "moves": [
//    {
//      "move": {
//        "name": "flash",
//        "url": "https://pokeapi.co/api/v2/move/148/"
//      },
//      "version_group_details": [
//        {
//          "level_learned_at": 0,
//          "version_group": {
//            "name": "x-y",
//            "url": "https://pokeapi.co/api/v2/version-group/15/"
//          },
//          "move_learn_method": {
//            "name": "machine",
//            "url": "https://pokeapi.co/api/v2/move-learn-method/4/"
//          }
//        }
//      ]
//    }
//  ],
//
//  "species": {
//    "name": "butterfree",
//    "url": "https://pokeapi.co/api/v2/pokemon-species/12/"
//  },
    
//  "stats": [
//    {
//      "base_stat": 70,
//      "effort": 0,
//      "stat": {
//        "name": "speed",
//        "url": "https://pokeapi.co/api/v2/stat/6/"
//      }
//    }
//  ],
    
}
