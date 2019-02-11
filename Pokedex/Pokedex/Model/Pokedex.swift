import Foundation

class Pokedex {
    static func searchForPokemon(with searchTerm: String, completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        let endpoint = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        let requestURL = endpoint.appendingPathComponent(searchTerm)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard error == nil, let data = data else {
                if let error = error {
                    NSLog("Error fetching data: \(error)")
                    completion(nil, error)
                }
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let searchResults = try jsonDecoder.decode(Pokemon.self, from: data)
                
                let name = searchResults.name
                let id = searchResults.id
                let types = searchResults.types
                let abilities = searchResults.abilities
                let sprites = searchResults.sprites
                
                let pokemon = Pokemon(abilities: abilities, id: id, name: name, sprites: sprites, types: types)
                
                Model.shared.pokemon = pokemon
                print("Pokemon count: \(String(describing: Model.shared.pokedex.count))")
                completion([pokemon], nil)
                
            } catch {
                NSLog("Unable to decode data into pokemon: \(error)")
                completion(nil, error)
                return
            }
        }
        dataTask.resume()
        
    }
}
