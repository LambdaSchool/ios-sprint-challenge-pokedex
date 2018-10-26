import Foundation

class PokemonController {
    
    private(set) var pokedex: [Pokemon] = []
    var sortedPokedex: [Pokemon] {
        return pokedex.sorted() { $0.name < $1.name}
    }
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    //MARK: - CRUD
    func createPokemon(pokemon: Pokemon) {
        pokedex.append(pokemon)
    }
    
    func deletePokemon(pokemon: Pokemon) {
        guard let index = pokedex.index(of: pokemon) else { return }
        
        pokedex.remove(at: index)
    }
    
    // Create a dataTask to GET Pokemon
    func searchForPokemon(searchText: String, completion: @escaping (Error?, Pokemon?) -> Void) {
        var requestURL = baseURL.appendingPathComponent("pokemon")
        requestURL.appendPathComponent(searchText)
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error searching for Pokemon: \(error)")
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                NSLog("Data not sent")
                completion(NSError(), nil)
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                self.pokemonArray.append(pokemon)
                completion(nil, pokemon)
            } catch {
                NSLog("Coud not decode data: \(error)")
                completion(error, nil)
                return
            }
        }.resume()
    }
    
}
