//
//  Model.swift
//  Pokedex
//
//  Created by Ivan Caldwell on 12/7/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import Foundation
import UIKit

class Model {
    static let shared = Model()
    private init() {}
    
    typealias UpdateHandler = () -> Void
    var updateHandler: UpdateHandler? = nil
    
    var pokemons: [Pokemon] = [] {
        didSet {
            DispatchQueue.main.async {
                self.updateHandler?()
            }
        }
    }
    

    func numberOfPokemons() -> Int {
        return pokemons.count
    }
    
    func Pokemon(at index: Int) -> Pokemon {
        return pokemons[index]
    }
    
    func search(for string: String) {
        PokemonAPI.searchForPokemons(with: string) { pokemons, error in
            if let error = error {
                NSLog("Error fetching pokemons: \(error)")
                return
            }

            self.pokemons = pokemons ?? []
        }
    }
}
