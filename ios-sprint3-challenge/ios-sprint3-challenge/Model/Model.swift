import Foundation

class Model {
    //MARK: Singleton
    static let shared = Model()
    private init() {}
    //MARK: Declared variables and constants
    let pokemonModelController = PokemonModelController()
    let pokemonSearchViewController: PokemonSearchViewController? = PokemonSearchViewController()
    var pokemon: PokemonModel?
    var savedpokemons: [PokemonModel] = []
    var numberOfPokemons: Int {
        return savedpokemons.count
    }
    
    func searchPokemon(pokemon: String) {
        pokemonModelController.fetchPokemon(for: pokemon) { error in
            if let error = error {
                NSLog("Could not call fetchPokemon method: \(error)")
                return
            }
        }
    }
    func savePokemon(for pokemon: PokemonModel) {
        savedpokemons.append(pokemon)
    }
    func deletePokemon(at indexPath: IndexPath) {
        savedpokemons.remove(at: indexPath.row)
    }
    func getTypes() {
        pokemon.type
        }
    func getAbilities() {
        
    }
}
