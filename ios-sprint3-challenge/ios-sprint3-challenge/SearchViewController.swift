import UIKit
import Foundation

class SearchViewController {
    
    let endpoint = "https://pokeapi.co/api/v2"
    var searchResults: [SearchResult] = []
    
    func performSearch (with searchTerm: String , resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        
        guard let baseURL = URL(string: endpoint) else { fatalError("Unable to construct baseURL") }
        
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            else { fatalError("Unable to resolve baseURL to components") }
        
        let searchQueryItem = URLQueryItem(name: "name", value: searchTerm)
        let typeResultTypeQueryItem = URLQueryItem(name: "type", value: resultType.rawValue)
        let abilitiesResultTypeQueryItem = URLQueryItem(name: "abilities", value: resultType.rawValue)
        let idResultTypeQueryItem = URLQueryItem(name: "id", value: resultType.rawValue)

        urlComponents.queryItems = [searchQueryItem, typeResultTypeQueryItem, abilitiesResultTypeQueryItem, idResultTypeQueryItem]

        guard let searchURL = urlComponents.url else { return }
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil, let data = data else {
                if let error = error {
                    NSLog("Error fetching data: \(error)")
                    completion(NSError())
                }
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let searchResults = try jsonDecoder.decode(SearchResult.SearchResults.self, from: data)
                self.searchResults = searchResults.results
                completion(nil)
            } catch {
                NSLog("Unable to decode data \(error)")
                completion(NSError())
            }
        }
        dataTask.resume()
    }
}
