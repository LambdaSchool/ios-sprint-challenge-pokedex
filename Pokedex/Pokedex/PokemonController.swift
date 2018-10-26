import Foundation

class PokemonController {
    
    private(set) var pokemonArray: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    // Create a dataTask to GET Pokemon
    func searchForPokemon(searchText: String, completion: @escaping (Error?) -> Void) {
        var requestURL = baseURL.appendingPathComponent("pokemon")
        requestURL.appendPathComponent(searchText)
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error searching for Pokemon: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned")
                completion(NSError())
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                self.pokemonArray.append(pokemon)
                completion(nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
}
