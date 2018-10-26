//
//  Model.swift
//  Pokedex
//
//  Created by Nikita Thomas on 10/26/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit

class Model {
    static let shared = Model()
    private init() {}
    
    var pokemon: [Pokemon] = []
    var searchPokemon: [Pokemon] = []
    var savedPokemon: [Pokemon] = []
    
    
    
    
}
