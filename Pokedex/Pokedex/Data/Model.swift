import Foundation

class Model {
    
    static let shared = Model()
    private init () {}
    var pokemon: Pokemon?
    var savedPokemon: [Pokemon] = []
    
    var numberOfPokemon: Int {
        return savedPokemon.count
    }
    
    func addPokemon(pokemon: Pokemon) {
        savedPokemon.append(pokemon)
        saveToPersistence()
    }
    
    func removePokemon(at indexPath: IndexPath) {
        savedPokemon.remove(at: indexPath.row)
        saveToPersistence()
    }
    
    func savedPokemon(at indexPath: IndexPath) -> Pokemon {
        saveToPersistence()
        return savedPokemon[indexPath.row]
    }
    
    private func loadToPersistence() {
        do {
            let memoriesData = try Data(contentsOf: memoriesFileURL)
            let decoder = JSONDecoder()
            let decodedMemories = try decoder.decode([Pokemon].self, from: memoriesData)
            
            memories = decodedMemories
        } catch {
            NSLog("Error decoding memories: \(error)")
        }
    }
    
    private func saveToPersistence() {
        let encoder = JSONEncoder()
        
        do {
            let memoriesData = try encoder.encode(memories)
            try memoriesData.write(to: memoriesFileURL)
        } catch {
            NSLog("Error encoding memories: \(error)")
        }
    }
    
    var memoriesFileURL = URL(fileURLWithPath: NSHomeDirectory())
        .appendingPathComponent("Documents")
        .appendingPathComponent("memories.json")
    
    var memories: [Pokemon] = []
}
