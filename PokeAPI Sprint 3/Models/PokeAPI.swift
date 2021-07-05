import UIKit

class PokemonSearchResultsController {
    
    let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    
    func performSearch(searchTerm: String, completion: @escaping (NSError?) -> Void) {
        
        let requestURL = URL(string: baseURL + searchTerm.lowercased())
        
        guard let searchRequestURL = requestURL
            else {
                NSLog("Could not make URL from components.")
                completion(NSError())
                return
        }
        
        // Make a request
        var request = URLRequest(url: searchRequestURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            // Check for errors. If there is an error, call completion with the error.
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(NSError())
                return
            }
            
            // Check for errors. If there is an error, call completion with the error.
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion(NSError())
                return
            }
            
            do {
                // Try to obtain a Pokemon from the API
                let pokemonSearchResults = try JSONDecoder().decode(Pokemon.self, from: data)
                // Store it in our Model
                PokedexModel.shared.selectedPokemon = pokemonSearchResults
                completion(nil)
   
                return
                
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(NSError())
                return
            }
        }
        
        dataTask.resume()
        
    }
    
}

