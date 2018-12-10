import UIKit

class Model {
    
    static let shared = Model()
    private init() {}
    
    // Updatehandler as a closure
    typealias Updatehandler = () -> Void
    var updateHandler: Updatehandler? = nil
    
    var pokemons: [Pokemon] = [] {
        
        didSet {
            DispatchQueue.main.async {
                self.updateHandler?()
            }
        }
        
    }
    
    // Return the number of pokemon that are currently stored in the model
    func numberOfPokes() -> Int {
        return pokemons.count
    }
    
    // Return the pokemon at a specific index path
    func poke(at index: Int) -> Pokemon {
        return pokemons[index]
    }
    
    // Return 
    func search(for string: String) {
        SearchResultController.performSearch(with: string) { (error) in
            if let error = error {
                NSLog("Error fetching people: \(error)")
                return
            }
        }
    }
    
    // Remove
    func removePoke(at indexPath: IndexPath) {
        
        // Get a pokemon
        //let pokemon = pokemons[indexPath.row]
        
        // Remove
        pokemons.remove(at: indexPath.row)
    }
    
}
