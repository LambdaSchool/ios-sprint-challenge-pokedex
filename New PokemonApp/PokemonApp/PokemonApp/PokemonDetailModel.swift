//
//  PokemonDetailModel.swift
//  PokemonApp
//
//  Created by Bhawnish Kumar on 4/10/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//


import Foundation
import UIKit

final class PokemonDetailViewModel {
    enum GetPokemonResult {
        case succesfulWithPokemon(Pokemon)
        case SuccessFulWithImage(UIImage)
        case failure(String)
    }
    private let pokemonController: PokemonController
    var pokemonName = [Pokemon]()
    
    // injecting the api controller here.
    init(pokemonController: PokemonController = PokemonController()) {
        self.pokemonController = pokemonController
    }
    
    func getPokemon(with name: String, completion: @escaping (GetPokemonResult) -> Void) {
        pokemonController.getPokemon(name) { result in
            // completion to do dispatchhmain queue
            DispatchQueue.main.async { [weak self] in
                do {
                    // it will work as a decoder.
                    let pokemon = try result.get()
                    completion(.succesfulWithPokemon(pokemon))
                    self?.getImage(for: pokemon, completion: completion)
                    
                } catch {
                    completion(.failure("Unable to fetch animal: \(name)"))
                    
                }
            }
        }
    }
    private func getImage(for pokemon: Pokemon, completion: @escaping (GetPokemonResult) -> Void) {
        pokemonController.fetchImage(at: pokemon.sprites) { result in
            DispatchQueue.main.async {
            do {
                let image = try result.get()
                completion(.SuccessFulWithImage(image))
            } catch {
                completion(.failure("Unable to fetch image : \(pokemon.name)"))
                }
            }
        }
    }
}
