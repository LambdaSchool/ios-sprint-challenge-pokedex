import Foundation

// A Pokedex is how one can discover and store Pokemon.
class PokedexModel {

    // Allows us to call on our model from other files.
    static let shared = PokedexModel()

    private init() {}

    // Array to store pokemon that the user would like to save, of type Pokemon to conform with the struct.
    // Declared as an empty array, unless you want to provide some for the user to play with.
    var savedPokemon: [Pokemon] = []
    
    // Creates a pokemon to store in our savedPokemon array by setting it to the Pokemon Struct
    var selectedPokemon: Pokemon?

    // Store the Pokemon that the user wants to save to saved Pokemon list
    func savePokemon() {
        // unwraps the user-chosen Pokemon
        guard let selectedPokemon = selectedPokemon else { return }
        // saves the selected Pokemon to the array
        savedPokemon.append(selectedPokemon)
    }
    
    // Removes Pokemon from the saved Pokemon list
    func removePokemon(indexPath: IndexPath) {
        // Removes Pokemon from the array
        savedPokemon.remove(at: indexPath.row)
    }
    
}
