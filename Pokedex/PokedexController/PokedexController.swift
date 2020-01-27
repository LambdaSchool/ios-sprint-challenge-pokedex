//
//  PokedexController.swift
//  Pokedex
//
//  Created by alfredo on 1/26/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import Foundation


class PokedexController{
    
    init(){
        getPokemonNamesAndURLS()
    }
    
    //MARK: - Properties
    
    let apiController = APIController()
    var pokedex: [String : PokedexEntry] = [:]
    var savedPokemon: [String] {
        return getSavedPokemon()
    }
    
    //MARK: - Methods
    
    func getPokemonNames()->[String]{
        var pokemonNames: [String] = []
        for (key,value) in pokedex{
            pokemonNames.append(value.name)
        }
        
        return pokemonNames
    }
    
    func getSavedPokemon() -> [String] {
        var savedPokemon: [String] = []
        
        for (key, _) in pokedex {
            if let pokemon = pokedex[key]{
                if pokemon.favorite == true{
                    savedPokemon.append(pokemon.name)
                }
            }
        }
        return savedPokemon.sorted()
    }
    
    func addRemainingPokemonInformationToPokedex(_ pokemonInfo: PokemonInformation, _ name: String, _ url: URL!){
        let abilites = pokemonInfo.abilities
        let height = pokemonInfo.height
        let species = pokemonInfo.species
        let id = pokemonInfo.id
        let images = pokemonInfo.sprites
        let weight = pokemonInfo.weight
        let type = pokemonInfo.types
        let pokedexEntry = PokedexEntry(abilities: abilites, favorite: false, height: height, id: id, images: images, name: name, species: species, types: type, url: url, weight: weight)
        
        pokedex[name] = pokedexEntry
    }

    func getInfo(_ url: URL!, _ name: String){
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
    
    func beginCreatingPokedex(_ allPokemon: APIPokedexRequestContainer){
        for pokemon in allPokemon.results{
            let name = pokemon.name
            let url = URL(string: pokemon.url)
            getInfo(url, name)
        }
    }
    
    func getPokemonNamesAndURLS(){
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
