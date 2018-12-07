import Foundation

class Model {
    static let shared = Model()
    private init() {}
    
    typealias UpdateHandler = () -> Void
    var updateHandler: UpdateHandler? = nil
    
    var pokemons: [SearchResult] = [] {
        
        didSet {
            DispatchQueue.main.async {
            self.updateHandler?()
            }
        }
    }
    
    func numberOfItems() -> Int {
        return pokemons.count
    }
    
    func pokemon(at index: Int) -> SearchResult {
        return pokemons[index]
    }
    func search(for string: String) {
        SearchViewController(with: string) { pokemon, error in
            if let error = error {
                NSLog("Error fetching pokemon: \(error)")
                return
            }
            
            self.pokemon = pokemon ?? []
        }
     
    
        func addNewPokemon(pokemon: SearchResult, complrtion: @escaping () -> Void) {
        pokemons.append(pokemon)
         

        }
    
    
    func deletePokemon(at indexPath: IndexPath, completion: @escaping () -> Void) {
        // let pokemon = pokemons(
        pokemons.remove(at: indexPath.row)
        
        }
}
}
