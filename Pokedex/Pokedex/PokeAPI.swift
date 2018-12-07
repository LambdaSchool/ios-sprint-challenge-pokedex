import Foundation

class PokeAPI {
    static let endpoint = "https://pokeapi.co/api/v2/"

    static func searchForPokemon(with searchTerm: String, completion: @escaping ([Pokemon]?, Error?) -> Void) {
        guard let baseURL = URL(string: endpoint)
            else { fatalError("Unable to construct baseURL")}
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }
        
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        
        urlComponents.queryItems = [searchQueryItem]
        
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            data, _, error in
            
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
                let people = searchResults.results
                
                completion(people, nil)
            }
            catch {
                NSLog("Unable to decode data into people: \(error)")
                completion(nil, error)
            }
        }
        
        dataTask.resume()
        
    }
}


