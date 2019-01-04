import Foundation

class Pokedex {
    static func searchForPokemon(with searchTerm: String, completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        let endpoint = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        let requestURL = endpoint.appendingPathComponent(searchTerm)
        
        // Create a GET request
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        print(requestURL)
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            // This closure is sent three parameters:
            data, _, error in
            
            // Rehydrate our data by unwrapping it
            guard error == nil, let data = data else {
                if let error = error { // this will always succeed
                    NSLog("Error fetching data: \(error)")
                    completion(nil, error) // we know that error is non-nil
                }
                return
            }
            do {
                // Declare, customize, use the decoder
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let searchResults = try jsonDecoder.decode(Pokemon.self, from: data)
                
                let name = searchResults.name
                let id = searchResults.id
                let types = searchResults.types
                let abilities = searchResults.abilities
                let sprites = searchResults.sprites
                
                // Send back the results to the completion handler
                let pokemon = Pokemon(abilities: abilities, id: id, name: name, sprites: sprites, types: types)
                print("Pokemon Name: \(pokemon.name)")
                print("Pokemon ID: \(pokemon.id)")
                print("Pokemon Types: \(pokemon.types)")
                print("Pokemon Abilities: \(pokemon.abilities)")
                
                Model.shared.addPokemon(pokemon: pokemon)
                // Send back the results to the completion handler
                completion([pokemon], nil)
                
            } catch {
                NSLog("Unable to decode data into pokemon: \(error)")
                completion(nil, error)
                //        return
            }
        }
        dataTask.resume()
        
        
    }
}
