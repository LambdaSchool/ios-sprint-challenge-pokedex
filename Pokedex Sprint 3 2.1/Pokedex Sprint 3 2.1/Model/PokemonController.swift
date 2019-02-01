import Foundation

class PokemonController {
    
    static let shared = PokemonController()
    private init() {}
    var pokemon: Pokemon?
    var savedPokemon: [Pokemon] = []
    
    func addPokemon(pokemon: Pokemon) {
        savedPokemon.append(pokemon)
    }
    
    func removePokemon(at indexPath: IndexPath) {
        savedPokemon.remove(at: indexPath.row)
    }
    
    func savedPokemon(at indexPath: IndexPath) -> Pokemon {
        return savedPokemon[indexPath.row]
    }
    
}
