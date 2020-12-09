//
//  PokedexController.swift
//  Pokedex
//
//  Created by alfredo on 1/26/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import Foundation


class PokedexController {
    
    // MARK: - Properties
    
    private let apiController = APIController()
    private let cachedPokedex: Pokedex
    private let userPokedex: Pokedex
    
    // MARK: - Init
    
    init() {
        self.cachedPokedex = Pokedex()
        self.userPokedex = Pokedex()
        self.getPokemonNamesAndURLS()
    }

    // MARK: - Methods
    
    func add(pokemon: Pokemon) {
        self.userPokedex.add(pokemon: pokemon)
    }
    
    func remove(pokemon: Pokemon) {
        self.userPokedex.remove(pokemon: pokemon)
    }
    
    func fetchPokemonNames(user: Bool, cached: Bool) -> [String] {
        if user {
            return self.userPokedex.fetchPokemonNames()
        }
        if cached {
            return self.cachedPokedex.fetchPokemonNames()
        }
        return []
    }
    
    func addRemainingPokemonInformationToPokedex(_ pokemonInfo: PokemonInformation, _ name: String, _ url: URL!) {
        let abilites = pokemonInfo.abilities
        let height = pokemonInfo.height
        let species = pokemonInfo.species
        let id = pokemonInfo.id
        let images = pokemonInfo.sprites
        let weight = pokemonInfo.weight
        let type = pokemonInfo.types
        let pokemon = Pokemon(abilities: abilites, addedToUserPokedex: false, height: height, id: id, images: images, name: name, species: species, types: type, url: url, weight: weight)
        
        self.cachedPokedex.add(pokemon: pokemon)
    }
    
    func fetchPokemon(pokemonName: String) -> Pokemon? {
        return self.cachedPokedex.fetchPokemon(pokemonName: pokemonName)
    }

    func getInfo(_ url: URL!, _ name: String) {
        apiController.fetchPokemonInformation(url) { result in
            do {
                let pokeInfo = try result.get()
                DispatchQueue.main.async {
                    self.addRemainingPokemonInformationToPokedex(pokeInfo, name, url)
                }}
            catch {
                if let error = error as? NetworkError {
                    switch error {
                    case .badAuth:
                        print("Error: Bad authorization")
                    case .badData:
                        print("Error: Bad data")
                    case .decodingError:
                        print("Error: Decoding error")
                    case .noAuth:
                        print("Error: No authoriztion")
                    case .otherError:
                        print("Error: Other error")
                    }}}
        }
    }
    
    func beginCreatingPokedex(_ allPokemon: APIPokedexRequestContainer) {
        for pokemon in allPokemon.results{
            let name = pokemon.name
            let url = URL(string: pokemon.url)
            self.getInfo(url, name)
        }
    }
    
    func getPokemonNamesAndURLS() {
        apiController.fetchAllPokemonNamesAndUrls { (result) in
            do {
                let allPokemon = try result.get()
                
                DispatchQueue.main.async {
                    self.beginCreatingPokedex(allPokemon)
                }
            }
            catch {
                if let error = error as? NetworkError {
                    switch error {
                    case .badAuth:
                        print("Error: Bad authorization")
                    case .badData:
                        print("Error: Bad data")
                    case .decodingError:
                        print("Error: Decoding error")
                    case .noAuth:
                        print("Error: No authoriztion")
                    case .otherError:
                        print("Error: Other error")
                    }
                }
            }
        }
    }
}
