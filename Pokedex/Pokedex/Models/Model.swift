//
//  Model.swift
//  Pokedex
//
//  Created by Austin Cole on 12/18/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import Foundation

class Model {
    //MARK: Singleton
    static let shared = Model()
    private init() {}
    
    var pokemon: PokemonModel?
    var pokemonTypes: PokemonModel.PokemonTypes?
    var pokemonAbilities: PokemonModel.PokemonAbility?
    var savedPokemons: [PokemonModel] = []
    let pokemonNetworkingClient = PokemonNetworkingClient()
    var numberOfSavedPokemons: Int {
        return savedPokemons.count
    }

    func savePokemon() {
        guard let pokemon = pokemon else {return}
        savedPokemons.append(pokemon)
        
    }
    func deletePokemon(indexPath: IndexPath){
        savedPokemons.remove(at: indexPath.row)
    }
}
