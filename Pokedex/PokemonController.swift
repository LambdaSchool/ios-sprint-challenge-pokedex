import UIKit

class PokemonController {
    
    var pokedex: [Pokemon] = []
    var pokemon: Pokemon?
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    func creatPokemon(pokemon: Pokemon) {
        pokedex.append(pokemon)
    }
    
    func deletePokemon(pokemon: Pokemon) {
        guard let indexPath = pokedex.index(of: pokemon) else {return}
        pokedex.remove(at: indexPath)
    }
    
    func performSearch(with searchTerm: String, completion: @escaping (Error?) -> Void) {
        
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }
        let nameQueryItem = URLQueryItem(name: "pokemon", value: searchTerm)
        //let idQueryItem = URLQueryItem(name: "id", value: searchTerm)
        
        urlComponents.queryItems = [nameQueryItem]
        
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Unable to unwrap data")
                completion(NSError())
                return
            }
            
            do {
                
                let decodedPokemon = try JSONDecoder().decode([Pokemon].self, from: data)
                
                self.pokedex = decodedPokemon
                completion(error)
                
            } catch {
                NSLog("Unable to decode data into pokemon")
                completion(error)
                return
            }
        }
        dataTask.resume()
    }
}
