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
    var short_effect: String // Has a 10% chance of making target Pokémon [flinch]{mechanic:flinch} with each hit.",
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

struct Pokemon: Codable {

    var id: Int                 // 1
    var name: String            // stench
    var is_main_series: Bool    // true
    
    var generation: Generation
    var names: [Names]

    var effect_entries: [EffectEntries]

    var effect_changes: [EffectChanges]

    var flavor_text_entries: [FlavorTextEntries]

    var pokemon: [PokemonImg]
}
