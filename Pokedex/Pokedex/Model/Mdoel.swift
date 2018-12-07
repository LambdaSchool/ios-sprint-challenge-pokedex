import Foundation

class Model {
    static let shared = Model()
    private init() {}
    var delegate: ModelUpdateClient?
    
    private var pokemons: [Pokemon] = []
    
    func count() -> Int {
        return pokemons.count
    }
    
    func pokemon(forIndex index: Int) -> Pokemon {
        return pokemons[index]
    }
    
    func setPokemon(pokemons: [Pokemon]) {
        Model.shared.pokemons = pokemons
    }
    
    // MARK: Core Database Management Methods
    
    
    func addNewPokemon(pokemon: Pokemon, completion: @escaping () -> Void) {
        
        // append it to our devices array, updating our local model <-- local
        pokemons.append(pokemon)
        
        // save it by pushing it to the firebase thing <-- remote
        Firebase<Pokemon>.save(item: pokemon){ success in
            guard success else {return}
            DispatchQueue.main.async { completion()}
        }
        delegate?.modelDidUpdate()
    }
    
    func deletePokemon(at indexPath: IndexPath, completion: @escaping () -> Void) {
        //
        let pokemon = pokemons[indexPath.row]
        
        //
        pokemons.remove(at: indexPath.row)
        
        // remote
        Firebase<Pokemon>.delete(item: pokemon){ success in
            guard success else {return}
            DispatchQueue.main.async { completion()}
        }
        
    }
    
    
    func updatePokemon(for person: Pokemon, completion: @escaping () -> Void) {
        //
        
        // TODO: do we need this?
        //device.uuid = UUID().uuidString
        
        // remote
        Firebase<Pokemon>.save(item: pokemon){ success in
            guard success else {return}
            DispatchQueue.main.async { completion()}
        }
        delegate?.modelDidUpdate()
    }
}
