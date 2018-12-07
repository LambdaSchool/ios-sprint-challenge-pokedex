import Foundation

class Pokedex {
    
    
    // Add the completion last
    static func searchForPokemon(with searchTerm: String, completion: @escaping ([Pokemon]?, Error?) -> Void) {
    
        var results = Model.shared.pokemons
        let endpoint = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        // Establish the base url for our search
        let requestURL = endpoint.appendingPathComponent(searchTerm)
        
        // Create a GET request
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        // Asynchronously fetch data
        // Once the fetch completes, it calls its handler either with data
        // (if available) _or_ with an error (if one happened)
        // There's also a URL Response but we're going to ignore it
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
            
            // We know now we have no error *and* we have data to work with
            
            // Convert the data to JSON
            // We need to convert snake_case decoding to camelCase
            // Oddly there is no kebab-case equivalent
            // Note issues with naming and show similar thing
            // For example: https://github.com/erica/AssetCatalog/blob/master/AssetCatalog%2BImageSet.swift#L295
            // See https://randomuser.me for future
            do {
                // Declare, customize, use the decoder
                let jsonDecoder = JSONDecoder()
                //jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                // Perform decoding into [Person] stored in PersonSearchResults
                let searchResults = try jsonDecoder.decode(PokeSearchResults.self, from: data)
                results = searchResults.results
                
                // Send back the results to the completion handler
                completion(results, nil)
                
                
            } catch {
                NSLog("Unable to decode data into pokemon: \(error)")
                completion(nil, error)
                //        return
            }
        }
        
        // A data task needs to be run. To start it, you call `resume`.
        // "Newly-initialized tasks begin in a suspended state, so you need to call this method to start the task."
        dataTask.resume()
    }
}
