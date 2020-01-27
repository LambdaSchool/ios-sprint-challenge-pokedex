import Foundation

// Network Errors
enum NetworkError: Error {
    case dataFetchError
    case badData
    case noDecode
}

class PokemonController {
    
    
    // MARK: - Properties
    
    // Base URL
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    // HTTPMethod Enums
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    
    // MARK: - Functions
    
    // (Function) Searching for a Pokemon
    func fetchPokemon(for pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let pokemonUrl = baseURL.appendingPathComponent("pokemon/\(pokemonName)")
               
               var request = URLRequest(url: pokemonUrl)
               request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                print("Error fetching data: \(error!)")
                completion(.failure(.dataFetchError))
                return
            }
            
            guard let data = data else {
                print("Error: No data returned from data task!")
                completion(.failure(.badData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Unable to decode data into object of type [Pokemon]: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
}
