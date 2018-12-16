

import Foundation

class Model {
    
    // Make it a singleton
    static let shared = Model()
    private init () {}
    
    // Variable for baseURL
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    // Holds the search result we get back
    var pokemon: Pokemon?
    //private var pokemon: Pokemon
    
    // Array to hold the saved pokemons
    var savedPokemons: [Pokemon] = []
    
    // Model Methods
    
    var numberOfPokemons: Int {
        return savedPokemons.count
    }
    
    var numberOfSavedPokemons: Int {
        return savedPokemons.count
    }
    
    func add(pokemon: Pokemon) {
        savedPokemons.append(pokemon)
    }
    
    func remove(at indexPath: IndexPath) {
        savedPokemons.remove(at: indexPath.row)
    }
    
    func findPokemon(at indexPath: IndexPath) -> Pokemon {
        return savedPokemons[indexPath.row]
    }
    
    func savedPokemon(at indexPath: IndexPath) -> Pokemon {
        return savedPokemons[indexPath.row]
    }
    
    
    // Function that lets us search for pokemons
    func performSearch(for searchTerm: String, completion: @escaping (Error?) -> Void) {
        
        // PUT TOGETHER A URL(urlRequest) TO MAKE A REQUEST/dataTask
        
        let requestURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        
            //var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: true)
        
            // Use component's URL property to create an actual URL to make our request on
            //guard let requestURL = components?.url else {
                //NSLog("Wasn't able to construct URL")
                //completion(NSError())
                //return
            //}
            //print(requestURL)
        
        // Now we have a valid URL
        
        // MAKE THE REQUEST/dataTask
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            // unwrap the error if we have one
            if let error = error {
                NSLog("Error fetching search results: \(error)")
                completion(error)
                return
            }
            
            // unwrap the data
            guard let data = data else {
                NSLog("Request didn't return valid data.")
                completion(NSError())
                return
            }
            
            // DO STUFF WITH THE RESULTS
            
            // Make JSON decoder
            
            let jsonDecoder = JSONDecoder()
            // Convert from snake case
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            // Convert the data
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                self.pokemon = pokemon
                print(pokemon)
                completion(nil)
                return
            } catch {
                NSLog("Error decoding JSON: \(error)")
                completion(error)
                return
            }
        }
        .resume()
        
        
        
    }
    
    
    
    
    
}
