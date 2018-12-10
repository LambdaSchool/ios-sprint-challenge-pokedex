import Foundation

class Model {
    static let shared = Model()
    private init () {}
    
    typealias UpdateHandler = () -> Void
    var updateHandler: UpdateHandler? = nil
    
    private(set) var pokedex: [Pokemon] = [] {
        didSet{
            DispatchQueue.main.async {
                self.updateHandler?()
            }
        }
    }
    
    var pokemon: Pokemon? {
        didSet{
            DispatchQueue.main.async {
                self.updateHandler?()
            }
        }
    }
    
    func numberOfPokemon() -> Int {
        return pokedex.count
    }
    
    func getPokemon(pokemon: Pokemon) -> Pokemon {
        return pokemon
    }
    
    func findPokemon(at index: Int) -> Pokemon {
        return pokedex[index]
    }
    
    func addPokemon(pokemon: Pokemon, completion: @escaping (Error?) -> (Void)) {
        pokedex.append(pokemon)
        completion(nil)
    }
    
    func deletePokemon(index: Int, completion: @escaping (Error?) -> (Void)) {
        pokedex.remove(at: index)
        completion(nil)
    }
    
    func search(for pokemon: String) {
        Pokedex.searchForPokemon(with: pokemon) { (pokedex, error) in
            if let error = error {
                NSLog("Error fetching Pokemon: \(error)")
                return
            }
            self.pokedex = pokedex ?? []
        }
    }
    
}
