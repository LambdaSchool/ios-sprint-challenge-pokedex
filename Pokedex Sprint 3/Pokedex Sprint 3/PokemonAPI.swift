
import Foundation


//https://pokeapi.co/api/v2/

class PokemonAPI {
    
    static let endpoint = "https://pokeapi.co/api/v2/"
    
    // Add the completion last
    static func searchForPokemon(with searchTerm: String, completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        guard let baseURL = URL(string: endpoint)
            else {
                fatalError("Unable to construct baseURL")
        }
        
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }
        
        let searchQueryItem = URLQueryItem(name: "pokemon", value: searchTerm)
        
 
        urlComponents.queryItems = [searchQueryItem]
        
    
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        

        var request = URLRequest(url: searchURL)
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
                
                
                let searchResults = try jsonDecoder.decode(PokemonSearchResults.self, from: data)
                let pokemon = searchResults.results
                
               
                completion(pokemon, nil)
                
            } catch {
                NSLog("Unable to decode data into pokemon: \(error)")
                completion(nil, error)
            }
        }
        dataTask.resume()
    }
}
