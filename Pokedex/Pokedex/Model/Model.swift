import Foundation

class Model {
    static let shared = Model()
    private init () {}
    
    typealias UpdateHandler = () -> Void
    var updateHandler: UpdateHandler? = nil
    
    var pokemons: [Pokemon] = [] {
        didSet { DispatchQueue.main.async {
            self.updateHandler?()
            }
        }
    }
    
    func numberOfPokemon() -> Int {
        return pokemons.count
    }
    
    func pokemon(at index: Int) -> Pokemon {
        return pokemons[index]
    }
    
    func deletePokemon(at indexPath: Int)  {
        pokemons.remove(at: indexPath)
    }
    
    func search(for string: String) {
        Pokedex.searchForPokemon(with: string) { pokemons, error in
            if let error = error {
                NSLog("Error fetching Pokemon: \(error)")
                return
            }
            self.pokemons = pokemons ?? []
        }
    }
}
