import Foundation

class PokemonModel {
    static let shared = PokemonModel()
    private init() {}
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    private var pokemon: [Pokemon] = []
    
    typealias CompletionHandler = (Error?) -> Void
    
    
    var numberOfPokemon: Int {
        return pokemon.count
    }
    
    func poke(at indexPath: IndexPath) -> Pokemon {
        return pokemon[indexPath.row]
    }
    
    func performSearch(with searchTerm: String, resultType: Pokemon, completion: @escaping CompletionHandler) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItems = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: "100")
        urlComponents?.queryItems = [searchQueryItems, resultTypeQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("Request URL is nil")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Could not load JSON: \(error)")
                completion(NSError())
            }
            
            guard let data = data else {
                NSLog("No data found")
                completion(NSError())
                return
            }
            
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                self.pokemon = searchResults.results
                completion(NSError())
            } catch {
                NSLog("Unable to decode JSON")
                completion(NSError())
            }
            } .resume()
    }
}
