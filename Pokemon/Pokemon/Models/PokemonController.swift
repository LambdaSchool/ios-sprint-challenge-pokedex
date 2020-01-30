import Foundation
import UIKit

class PokemonController {
    
    
    // MARK: - Properties
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    var savedPokemon: [Pokemon] = []
    
    
    // MARK: - Functions
    
    // Fetch a Pokemon
    func fetchPokemon(for pokemonName: String, completion: @escaping (Pokemon?) -> Void) {
        
        let requestURL = baseURL.appendingPathComponent("pokemon/\(pokemonName)")
               
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
                   
                   if let error = error {
                       NSLog("Error with data task: \(error)")
                       completion(nil)
                       return
                   }
                   
                   guard let data = data else {
                       NSLog("No data was returned from the data task")
                       completion(nil)
                       return
                   }
                   
                   // Create a JSON Decoder
                   let jsonDecoder = JSONDecoder()
                   
                   do {
                    let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                       completion(pokemon)
                   } catch {
                       NSLog("Unable to decode data into type Pokemon: \(error)")
                       completion(nil)
                       return
                   }
               }.resume()
    }
    
    // Fetch Pokemon Image
    func fetchImage(at urlString: String, completion: @escaping (UIImage?) -> Void) {
        let imageURL = URL(string: urlString)!
        
        let request = URLRequest(url: imageURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)!
            completion(image)
        }.resume()
    }
}
