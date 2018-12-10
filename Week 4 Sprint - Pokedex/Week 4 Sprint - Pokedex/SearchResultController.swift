
import UIKit

// https://pokeapi.co/api/v2/pokemon/
// 1) make my own internal API call to this ^^
// 2) store all the pokemon as a dict: when I call urls['bulbasaur'] it returns: "/pokemon/1/"
// 3) so that when someone types into the search "bulbasaur", it passes that string to the urls
//     it returns baseURL + urls['bulbsaur']

// count: 949



class SearchResultController {
    
    static let baseURL = "https://pokeapi.co/api/"
    
    // Data source for table view
    var pokemons: [Pokemon] = []
    
    // Search
    static func performSearch(with searchTerm: String, completion: @escaping (NSError?) -> Void) {
        
        // Establish baseURL for the search
        guard let baseURL = URL(string: baseURL)
            else {
                fatalError("Unable to construct baseURL")
        }
        
        // Decompose it into its components
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }
        
        // Create the query items
        let searchQueryItem = URLQueryItem(name: "pokemon", value: searchTerm)
            //let secondSearchQueryItem = URLQueryItem(name: "id", value: searchTerm) // this won't work
            //let thirdSearchQueryItem = URLQueryItem(name: "type", value: searchTerm)
            //let fourthSearchQueryItem = URLQueryItem(name: "ability", value: searchTerm)
            //let fifthSearchQueryItem = URLQueryItem(name: ")
        
        // Add in the query items / search term
        urlComponents.queryItems = [searchQueryItem]
        
        // Recompose individual components back into a fully realized search URL
        guard let searchURL = urlComponents.url else { return }
            //NSLog("Error construction search URL for \(searchTerm)")
            // completion
            //completion(NSError)
            //return
        //}
        
        // ^^ search URL created, but haven't done anything with it yet
        
        // Create a GET request
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        // Asynchronously fetch data
        // Create a data task that is a URLSession, that runs the URL and fetches the data
        let dataTask = URLSession.shared.dataTask(with: request) {
            
            // Completion handler with three parameters:
            data, _, error in
            
            // Unwrap data to ensure we have data and we don't have an error
            guard error == nil, let data = data else {
                if let error = error {
                    NSLog("Error fetching data: \(error)")
                    completion(NSError())
                }
                return
            }
            
            // We know now that we have no error AND we have data to work with
            
            // Convert the data to JSON
            do {
                // Declare the decoder
                let jsonDecoder = JSONDecoder()
                
                // convert from snake_case to camelCase
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                // Perform decoding into [Pokemon] stored in PokemonSearchResults
                let pokemons = try jsonDecoder.decode(Pokemon.PokemonSearchResults.self, from: data)
                self.pokemons = pokemons.results
                
                completion(nil)
                
            } catch {
                NSLog("Unable to decode data into search results: \(error)")
                completion(NSError())
            }
        }
        
        dataTask.resume()
        
    }
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

