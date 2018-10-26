import UIKit

class PokemonController {
    
    var pokemon: [Pokemon] = []
    
    private let baseURL = URL(string: "https://pokeapi.co")!
    
    
    func performSearch(with searchTerm: String, completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }
        let nameQueryItem = URLQueryItem(name: "name", value: searchTerm)
        //let idQueryItem = URLQueryItem(name: "id", value: searchTerm)
        
        urlComponents.queryItems = [nameQueryItem]
        
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            
            
        }
        
    }
    
}
