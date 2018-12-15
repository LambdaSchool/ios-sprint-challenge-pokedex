

import Foundation

class Pokes {
    
    // Variable for baseURL
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    // Function that lets us search for pokemons
    static func performSearch(for searchTerm: String, completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        // PUT TOGETHER A URL(urlRequest) TO MAKE A REQUEST/dataTask
        
        let requestURL = baseURL.appendingPathComponent(searchTerm)
        
        // Now we have a valid URL
        
        // MAKE THE GET REQUEST/dataTask
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            // unwrap the error if we have one
            if let error = error {
                NSLog("Error fetching search results: \(error)")
                completion(nil, error)
                return
            }
            
            // unwrap the data
            guard let data = data else {
                NSLog("Request didn't return valid data.")
                completion(nil, NSError())
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
                var savedPokemons = Model.shared.savedPokemons
                savedPokemons = [pokemon]
                completion(savedPokemons, nil)
                return
            } catch {
                NSLog("Error decoding JSON: \(error)")
                completion(nil, error)
                return
            }
        }
        .resume()
        
    }
}
