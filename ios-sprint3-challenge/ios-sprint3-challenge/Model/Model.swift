import Foundation

class Model {
    //MARK: Singleton
    static let shared = Model()
    private init() {}
    //MARK: Declared variables and constants
    let pokemonModelController = PokemonModelController()
    let pokemonSearchViewController: PokemonSearchViewController? = PokemonSearchViewController()
    var pokemon: PokemonModel?
    var pokemonTypes: PokemonModel.PokemonType?
    var pokemonAbilities: PokemonModel.PokemonAbility?
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
    func getAbilities() -> String {
        var pokemonAbilitiesArray: [String] = []
        guard let pokemon = pokemon else {return ""}
        for count in 0...(pokemon.abilities.count - 1) {
            pokemonAbilitiesArray.append((pokemon.abilities[count].ability["name"])!)
        }
        return pokemonAbilitiesArray.joined(separator: ", ")
        }
    func getTypes() -> String {
        var pokemonTypesArray: [String] = []
        guard let pokemon = pokemon else {return ""}
        for count in 0...(pokemon.types.count - 1) {
            pokemonTypesArray.append((pokemon.types[count].type["name"])!)
        }
        return pokemonTypesArray.joined(separator: ", ")
    }
    func getID () -> String {
        guard let pokemon = pokemon else {return ""}
        let pokemonID = "\(pokemon.id)"
        return pokemonID
    }
}
