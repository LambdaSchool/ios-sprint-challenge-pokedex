import Foundation

class Model {
    static let shared = Model()
    private init () {}
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    private var pokemon: [SearchResults] = []
    
    var numberOfPokemon: Int {
        return pokemon.count
    }
    
    func pokemon(at indexPath: IndexPath) -> SearchResults {
        return pokemon[indexPath.row]
    }
    
    func search(for searchTerm: String, completion: @escaping (Error?) -> Void) {
        // Put together a URL (or URLRequest) to make a dataTask with
        // Construct the URL Components
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchQueryItem = URLQueryItem(name: "\(searchTerm)", value: searchTerm)
        
        components?.queryItems = [searchQueryItem]
        
        guard let requestURL = components?.url else {
            NSLog("Was not able to construct URL.")
            completion(NSError())
            return
        }
        
        
        // Make the dataTask
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching search results: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Request did not return valid data.")
                completion(NSError())
                return
            }
            
            // Do stuff with the results
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.pokemon = [searchResults]
                completion(nil)
                return
            } catch {
                NSLog("Error decoding JSON: \(error)")
                completion(error)
                return
            }
            }.resume()
    }
    
}
