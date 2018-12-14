import Foundation

class Model {
    static let shared = Model()
    private init() {}
    
    typealias UpdateHandler = () -> Void
    var updateHandler: UpdateHandler? = nil
    let searchAPI = SearchAPI()
    var pokemon: Pokemon?
    var pokemons: [Pokemon] = []

    
    let resultType = ResultType.self
    
    
    func numberOfItems() -> Int {
        return pokemons.count
    }
    
    func pokemonAtIndex(indexPath: IndexPath) -> Pokemon {
        return pokemons[indexPath.row]
    }
    func pokemon(at index: Int) -> Pokemon {
        return pokemons[index]
    }
    func search(searchTerm: String) {
        searchAPI.performSearch(with: searchTerm, resultType: resultType.rawValue) { (pokemon, error) in
        
    if let error = error {
    NSLog("Error fetching data: \(error)")
    return
    }
            self.pokemon = pokemon!
        }
    }
        // self.pokemons = pokemons
    
     
    
func addNewPokemon(pokemon: Pokemon) {
          Model.shared.pokemons.append(pokemon)
         
}

    func delete(pokemons: Pokemon) {
        guard let index = Model.shared.pokemons.index(of: pokemons) else { return }
        Model.shared.pokemons.remove(at: index)
    }

    
}

