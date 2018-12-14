//
//  PokemonModel.swift
//  Podex II
//
//  Created by Ivan Caldwell on 12/14/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import Foundation
class PokemonModel {
    static let shared = PokemonModel()
    private init () {}
    var pokemons: [Pokemon] = []

}
