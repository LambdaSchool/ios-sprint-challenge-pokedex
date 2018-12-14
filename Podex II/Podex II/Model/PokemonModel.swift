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
    
//        {
//        didSet {
//            loadData()
//        }
//    }
    
//    func addPokemon(_ pokemon: Pokemon) {
//        pokemons.append(pokemon)
//        //saveData()
//    }
//
//    func removePokemon(at index: Int) {
//        pokemons.remove(at: index)
//        saveData()
//    }
//
//    func movePokemon(from index: Int, to destinationIndex: Int) {
//        let pokemon = pokemons.remove(at: index)
//        pokemons.insert(pokemon, at: destinationIndex)
//        saveData()
//    }
//
//
//
//    func pokemon(at index: Int) -> Pokemon {
//        return pokemons[index]
//    }
//    
//    let fileURL = URL(fileURLWithPath: NSHomeDirectory())
//        .appendingPathComponent("Library")
//        .appendingPathComponent("Video")
//        .appendingPathExtension("plist")
//    
//    func saveData() {
//        try! (pokemons as NSArray).write(to: fileURL)
//    }
//    
//    func loadData() {
//        if let pokemons = NSArray(contentsOf: fileURL) as? [Pokemon] {
//            self.pokemons = pokemons
//        }
//    }


}
