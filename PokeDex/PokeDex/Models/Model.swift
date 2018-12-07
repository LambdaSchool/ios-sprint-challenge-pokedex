import Foundation

class Model {
    
    static let shared = Model()
    private init() {}
    
    var filteredPokemon : [Pokemon] = []
    var savedPokemon: [Pokemon] = []
    var pokemon: [Pokemon] = []
    
    func numberOfPokemon() -> Int {
        return pokemon.count
    }
    
    func pokemonAtIndex(indexPath: IndexPath) -> Pokemon {
        return pokemon[indexPath.row]
    }
    
    func search(searchTerm: String) {
        PokemonNetworkingClient.searchForPokemon(with: searchTerm) { pokemon, error in
            if let error = error {
                NSLog("error searching for pokemon\(error)")
                return
            }
            self.pokemon = pokemon!
        }
    }
    
    func savePokemon(pokemon: Pokemon) {
        savedPokemon += [pokemon]
    }
    
    func pokemonAt(index: Int) -> Pokemon{
        return pokemon[index]
    }
    
    
}


