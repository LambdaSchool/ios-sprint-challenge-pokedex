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
            
            // Great opportunity to use nil coalescing to convert
            // a nil result into the empty array
            self.pokemon = pokemon ?? []
        }
    }
}
