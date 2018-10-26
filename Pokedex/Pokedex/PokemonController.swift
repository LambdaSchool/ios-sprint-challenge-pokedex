import Foundation

class PokemonController {
    
    private(set) var pokemonArray: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
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
