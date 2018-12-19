import Foundation

class Model {
    static let shared = Model()
    private init() {}
    
    typealias UpdateHandler = () -> Void
    var updateHandler: UpdateHandler? = nil
    let searchAPI = SearchAPI()
    var pokemon: Pokemon?
    var pokemons: [Pokemon] = []

    
    func numberOfPokemons() -> Int {
        return pokemons.count
    }
    
    func pokemonAtIndex(indexPath: IndexPath) -> Pokemon {
        return pokemons[indexPath.row]
    }
    func pokemon(at index: Int) -> Pokemon {
        return pokemons[index]
    }
  
    func addNewPokemon() {
        guard let pokemon = pokemon else {return}
          pokemons.append(pokemon)
    }
    
    func deletePokemon(at indexPath: IndexPath) {
        pokemons.remove(at: indexPath.row)
    }

}

