//
//  Pokemon+Convenience.swift
//  Pokedex
//
//  Created by Kenneth Jones on 12/9/20.
//  Copyright © 2020 Kenneth Jones. All rights reserved.
//

import Foundation
import CoreData

extension Pokemon {
    // Allows me to initialize an object with the attributes of the object instead of just the context.
    @discardableResult convenience init(id: Int,
                                        name: String,
                                        types: [String],
                                        abilities: [String],
                                        sprite: Data? = nil,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.id = Int16(id)
        self.name = name
        self.types = types
        self.abilities = abilities
        self.sprite = sprite
    }
    
    // Wrapper around my other initializer, given a pokemon representation, instantiate a pokemon object.
    @discardableResult convenience init?(pokemonRepresentation: PokemonRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(id: pokemonRepresentation.id,
                  name: pokemonRepresentation.name,
                  types: pokemonRepresentation.types,
                  abilities: pokemonRepresentation.abilities,
                  context: context)
    }
}
