import Foundation

class Model {
    static let shared = Model()
    private init() {}
    
    typealias UpdateHandler = () -> Void
    var updateHandler: UpdateHandler? = nil
    
    var pokemons: [SearchResult] = [] {
        
        didSet {
            DispatchQueue.main.async {
            //    Model.UpdateHandler?()
            }
        }
    }
    
    
    
    func numberOfItems() -> Int {
        return pokemons.count
    }
    
    func pokemon(at indexPath: IndexPath) -> SearchResult {
        return pokemons[indexPath.row]
    }
    
    // MARK: Core Database Management Methods
    
//    func addNewPokemon(completion: @escaping () -> Void) {
//        let pokemon = SearchResult.
//
//        pokemons.append(pokemon)
//
//
//        }
    
    
    func deletePokemon(at indexPath: IndexPath, completion: @escaping () -> Void) {
        let pokemon = pokemons[indexPath.row]
        pokemons.remove(at: indexPath.row)
        
        }
}
