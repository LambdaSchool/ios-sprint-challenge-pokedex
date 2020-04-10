//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Hunter Oppel on 4/10/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation
import UIKit

final class PokemonDetailViewModel {
    
    // MARK: Properties
    
    enum GetPokemonResult {
        case successfulWithPokemon(Pokemon)
        case successfulWithSprite(UIImage)
        case failure(String)
    }
    
    private let pokemonController: PokemonController
    
    init(pokemonController: PokemonController = PokemonController()) {
        self.pokemonController = pokemonController
    }
    
    func getPokemon(with name: String, completion: @escaping (GetPokemonResult) -> Void) {
        pokemonController.fetchPokemonWith(searchTerm: name) { result in
            DispatchQueue.main.async { [weak self] in
                do {
                    let pokemon = try result.get()
                    completion(.successfulWithPokemon(pokemon))
                    self?.getSprite(for: pokemon, completion: completion)
                } catch {
                    completion(.failure("Failed to fetch pokemon: \(name)"))
                }
            }
        }
    }
    
    func getSprite(for pokemon: Pokemon, completion: @escaping (GetPokemonResult) -> Void) {
        pokemonController.fetchPokemonSprite(spriteURLString: pokemon.sprites.spriteURL) { result in
            DispatchQueue.main.async {
                do {
                    let sprite = try result.get()
                    completion(.successfulWithSprite(sprite))
                } catch {
                    completion(.failure("Failed to fetch sprite: \(pokemon.name)"))
                }
            }
        }
    }
}
