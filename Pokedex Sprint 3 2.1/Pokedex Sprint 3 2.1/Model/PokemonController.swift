import Foundation

class PokemonController {
    
    static let shared = PokemonController()
    private init() {}
    var pokemon: Pokemon?
    var savedPokemon: [Pokemon] = []
   // var memories: [Pokemon] = []
    
    func addPokemon(pokemon: Pokemon) {
        savedPokemon.append(pokemon)
        saveToPersistence()
    }
    
    func removePokemon(at indexPath: IndexPath) {
        savedPokemon.remove(at: indexPath.row)
        saveToPersistence()
    }
    
    func savedPokemon(at indexPath: IndexPath) -> Pokemon {
        return savedPokemon[indexPath.row]
    }
    
    func loadToPersistence() {
        do {
            let memoriesData = try Data(contentsOf: memoriesFileURL)
            let decoder = JSONDecoder()
            let decodedMemories = try decoder.decode([Pokemon].self, from: memoriesData)
            
            savedPokemon = decodedMemories
        } catch {
            NSLog("Error decoding memories: \(error)")
        }
    }
    
    private func saveToPersistence() {
        let encoder = JSONEncoder()
        
        do {
            let memoriesData = try encoder.encode(savedPokemon)
            try memoriesData.write(to: memoriesFileURL)
        } catch {
            NSLog("Error encoding memories: \(error)")
        }
    }
    
    var memoriesFileURL = URL(fileURLWithPath: NSHomeDirectory())
        .appendingPathComponent("Documents")
        .appendingPathComponent("memories.json")
    
}

    

