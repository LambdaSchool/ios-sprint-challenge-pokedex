//  Copyright © 2019 Frulwinn. All rights reserved.

import Foundation

class Model {
    
    static let shared = Model()
    private init () {}
    
    //baseURL for api
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    //MARK: Properties
    var pokemons: [Pokemon] = []
    
    //MARK: Methods
    //count
    func numberOfPokemons() -> Int {
        return pokemons.count
    }
    
    //access pokemon at index
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        return pokemons[indexPath.row]
    }
    
    //add
    func addPokemon(pokemon: Pokemon) {
        pokemons.append(pokemon)
    }
    
    //delete
    func deletePokemon(at indexPath: IndexPath) {
        pokemons.remove(at: indexPath.row)
    }
    
    //update
    func updatePokemon(at indexPath: IndexPath) {
        let _ = pokemons[indexPath.row]
    }
}
