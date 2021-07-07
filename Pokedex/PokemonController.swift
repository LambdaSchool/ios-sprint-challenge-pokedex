import UIKit

let baseURL = URL(string: "https://pokeapi.co/api/v2/")!

class PokemonController {
    
    static let shared = PokemonController()
    private init() {}
    
    var pokemon: Pokemon?
    var pokedex: [Pokemon] = []
    
    
    func performSearch(with searchTerm: String, completion: @escaping () -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchQueryItem = URLQueryItem(name: "pokemon", value: searchTerm)
        
        urlComponents?.queryItems = [searchQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("RequestURL could not be found")
            completion()
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                NSLog("There was a problem getting data from JSON: \(error)")
                completion()
                return
            }
            
            guard let data = data else {
                NSLog("No data found")
                completion()
                return
            }
            
            
            // SOMETHING IS WRONG HERE?!?!?! ARRRGGHHHGH
            do {
                JSONDecoder().keyDecodingStrategy = .convertFromSnakeCase
                
                let pokemonResult = try JSONDecoder().decode(Pokemon.self, from: data)
                
                self.pokemon = pokemonResult
                completion()
            } catch {
                NSLog("Unable to decode JSON.")
                completion()
                return
            }
        }
        dataTask.resume()
    }
    
    
    func createPokemon(pokemon: Pokemon) {
        pokedex.append(pokemon)
    }
    
    func deletePokemon(pokemon: Pokemon) {
        guard let indexPath = pokedex.index(of: pokemon) else {return}
        pokedex.remove(at: indexPath)
    }
}
