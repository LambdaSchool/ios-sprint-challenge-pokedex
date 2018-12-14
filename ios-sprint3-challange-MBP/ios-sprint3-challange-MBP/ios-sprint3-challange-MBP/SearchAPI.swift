import UIKit
import Foundation

class SearchAPI {
    
    let endpoint = "https://pokeapi.co/api/v2/pokemon/"
    var searchResults: [Pokemon] = []
    
    func performSearch (with searchTerm: String , resultType: ResultType, completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        
        guard let baseURL = URL(string: endpoint) else { fatalError("Unable to construct baseURL") }
        let finalURL = baseURL.appendingPathComponent(searchTerm)
        
        guard let urlComponents = URLComponents(url: finalURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }
        
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
                    completion(nil, NSError())
                }
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let searchResults = try jsonDecoder.decode(PokemonSearchResult.self, from: data)
                let poke = searchResults.results
                completion(poke, nil)
            } catch {
                NSLog("Unable to decode data \(error)")
                completion(nil, NSError())
            }
        }
        dataTask.resume()
    }
}
