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
    
    func search(for string: String) {
        PokeAPI.searchForPokemon(with: string) { pokemon, error in
            if let error = error {
                NSLog("Error fetching pokemon: \(error)")
                return
            }

            self.pokemon = pokemon ?? []
        }
    }
}
