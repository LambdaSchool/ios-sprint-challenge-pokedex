

import Foundation

class Model {
    
    // Make it a singleton
    static let shared = Model()
    private init () {}

    typealias Updatehandler = () -> Void
    var updateHandler: Updatehandler? = nil
    
    // Array to hold the saved pokemons
    var savedPokemons: [Pokemon] = [] {
        
        didSet {
            DispatchQueue.main.async {
                self.updateHandler?()
            }
        }
    }
    
    // Array to hold the search results we get back
    //private var pokemon: Pokemon?
    //private var pokemon: [Pokemon] = []
    

    
    // Model Methods
    
    var numberOfSavedPokemons: Int {
        return savedPokemons.count
    }
    
    func add(pokemon: Pokemon) {
        savedPokemons.append(pokemon)
    }
    
    func remove(at indexPath: IndexPath) {
        savedPokemons.remove(at: indexPath.row)
    }
    
    func findPokemon(at indexPath: IndexPath) -> Pokemon {
        return savedPokemons[indexPath.row]
    }
    
    func search(for string: String) {
        Pokes.performSearch(for: string) { (pokemon, error) in
            if let error = error {
                NSLog("Error fetching pokemon: \(error)")
                return
            }
            self.savedPokemons = pokemon ?? []
        }
    }
    
}
