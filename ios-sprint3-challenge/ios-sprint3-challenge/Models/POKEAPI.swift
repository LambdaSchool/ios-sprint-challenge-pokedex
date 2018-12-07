import Foundation

class POKEAPI {
    static let endpoint = "https://pokeapi.co/api/v2/pokemon/"
    var searchResult: [Pokemon] = []
    
    static func searchForPokemon(with searchTerm: String, completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let base = endpoint + "\(searchTerm)"
        //construct baseURL
        guard let baseURL = URL(string: base) else {fatalError("Unable to construct base URL from endpoint")}
        
        //Break baseURL into its components
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else { fatalError("Unable to resolve baseURL components")}
        
        
        //Add in the searchTerm as URLComponent path
        //urlComponents.fragment = searchTerm
        
        // Re-compose the components back into a valid URL
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing a valid URL")
            completion(nil, NSError())
            return
        }
        print(searchURL)
        // create the GET request
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        print(request)
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            data, _, error in
            
            //Unwrap data
            guard error == nil, let data = data else {
                if let error = error {
                    NSLog("Could not unwrap data: \(error)")
                    completion(nil, error)
                }
                return
            }
            
            //Decode the data
            
            do {
                //instantiate a JSONDecoder
                let decoder = JSONDecoder()
                
                // decode into PokemonSearchResult
                let searchResults = try decoder.decode(PokemonSearchResult.self, from: data)
                let pokemon = searchResults.results
                completion(pokemon, nil) } catch {
                    NSLog("Unable to decode data")
                    completion(nil, error)
                
            }
        }
        dataTask.resume()
    }
}
