

import Foundation

class Model {
    
    // Make it a singleton
    static let shared = Model()
    private init () {}
    
    // Variable for baseURL
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    // Array to hold the search results we get back
    private var pokemons: [Pokemon] = []
    // Array to hold the saved pokemons
    var savedPokemons: [Pokemon] = []
    
    // Model Methods
    
    var numberOfPokemons: Int {
        return pokemons.count
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
        return pokemons[indexPath.row]
    }
    
    func savedPokemon(at indexPath: IndexPath) -> Pokemon {
        return savedPokemons[indexPath.row]
    }
    
    
    // Function that lets us search for pokemons
    func performSearch(for searchTerm: String, completion: @escaping (Error?) -> Void) {
        
        // PUT TOGETHER A URL(urlRequest) TO MAKE A REQUEST/dataTask
        
        let fullURL = baseURL.appendingPathComponent(searchTerm)
        
        var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: true)
        
        // Query item for our search
        //let searchQueryItem = URLQueryItem(name: "", value: searchTerm)
        
        // Give query item to the components
        //components?.queryItems = [searchQueryItem]
        
        // Use component's URL property to create an actual URL to make our request on
        guard let requestURL = components?.url else {
            NSLog("Wasn't able to construct URL")
            completion(NSError())
            return
        }
        
        // Now we have a valid URL which contains our ID and our query
        
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
                let pokemons = try jsonDecoder.decode(Pokemon.self, from: data)
                self.pokemons = [pokemons]
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
