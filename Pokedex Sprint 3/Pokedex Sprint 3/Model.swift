import UIKit

class Model {
    
    static let shared = Model()
    private init() {}
    
    typealias UpdateHandler = () -> Void
    var updateHandler: UpdateHandler? = nil

    var pokemon: [Pokemon] = [] {
        didSet {
            DispatchQueue.main.async {
                self.updateHandler?()
            }
        }
    }
    
    func numberOfPokemon() -> Int {
        return pokemon.count
    }
    
    func pokemon(at index: Int) -> Pokemon {
        return pokemon[index]
    }
    
//    func add(pokemon: Pokemon) {
//        pokemon.append(pokemon)
//    }
    
    func search(for string: String) {
        PokemonAPI.searchForPokemon(with: string) { pokemon, error in
            if let error = error {
                NSLog("Error fetching people: \(error)")
                return
            }
            self.pokemon = pokemon ?? []
        }
    }
}
