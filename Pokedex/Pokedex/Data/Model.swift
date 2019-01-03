import Foundation

class Model {
    
    static let shared = Model()
    private init() {}
    var pokemon: Pokemon?
    var savedPokemon: [Pokemon] = []
    
    func numberOfpokemon() -> Int {
        return savedPokemon.count
    }
    
    func addPokemon(pokemon: Pokemon) {
        savedPokemon.append(pokemon)
    }
    
    func removePokemon(at indexPath: IndexPath) {
        savedPokemon.remove(at: indexPath.row)
    }
    
    func savePokemon(at indexPath: IndexPath) -> Pokemon {
        return savedPokemon[indexPath.row]
    }
}
