import Foundation

class SearchResultController {
    // should URL have /pokemon?
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    static let shared = SearchResultController()
    private init() {}
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItems = URLQueryItem(name: "name", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "id", value: resultType.rawValue)
        urlComponents?.queryItems = [searchQueryItems, resultTypeQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("Request URL is nil")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){ (data, _, error) in
            if let error = error {
                NSLog("There was a problem getting data from JSON: \(error)")
                completion(NSError())
            }
            
            guard let data = data else {
                NSLog("No data found")
                completion(NSError())
                return
            }
            
            // MARK: - Error - FIX THIS - Unable to decode JSON -
            do {
                let searchResults = try
                    JSONDecoder().decode(ResultsList.self, from : data)
                self.searchResults = searchResults.results
                completion(NSError())
            } catch {
                NSLog("Unable to decode JSON")
                completion(NSError())
            }
        } .resume()
    }
    var searchResults: [SearchResult] = []
}
