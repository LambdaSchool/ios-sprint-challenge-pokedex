import Foundation

class PokedexModel {
    
    static let shared = PokedexModel()
    private init(){}
    
    static let savedPokemon: [Pokemon] = []
}
