import UIKit

class PokemonSearchResultsController {
    
    static let shared = PokemonSearchResultsController()
    
    let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    // search results array, data source for the table view
    var searchResults: [Pokemon] = []
    
    func performSearch(searchTerm: String, completion: @escaping ([Pokemon]?, NSError?) -> Void) {
        
        let requestURL = URL(string: baseURL + searchTerm)
        
        guard let searchRequestURL = requestURL
            else {
                NSLog("Could not make URL from components.")
                completion(nil, NSError())
                return
        }
        
        // Make a request
        var request = URLRequest(url: searchRequestURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            // Check for errors. If there is an error, call completion with the error.
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, NSError())
                return
            }
            
            // Check for errors. If there is an error, call completion with the error.
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion(nil, NSError())
                return
            }
            
            do {
                let searchResults = try JSONDecoder().decode(PokemonSearchResults.self, from: data)
               self.searchResults = searchResults.results
                completion(self.searchResults, nil)
   
                return
                
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(nil, NSError())
                return
            }
        }
        
        dataTask.resume()
        
    }
    
}

