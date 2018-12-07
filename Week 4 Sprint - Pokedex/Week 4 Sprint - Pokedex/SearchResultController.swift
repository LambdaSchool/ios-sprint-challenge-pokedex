
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
    var searchResults: [SearchResult] = []
    
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
        let searchQueryItem = URLQueryItem(name: "pokemon-species", value: searchTerm)
        let secondSearchQueryItem = URLQueryItem(name: "id", value: searchTerm) // this won't work
        let thirdSearchQueryItem = URLQueryItem(name: "type", value: searchTerm)
        let fourthSearchQueryItem = URLQueryItem(name: "ability", value: searchTerm)
        let fifthSearchQueryItem = URLQueryItem(name: ")
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
