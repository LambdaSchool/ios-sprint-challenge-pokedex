import Foundation

class PokemonModelController {
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")
    var pokemon: PokemonModel?
    let pokemonSearchViewController = PokemonSearchViewController()
    
    func fetchPokemon(for searchedPokemon: String, completion: @escaping (Error?) -> Void) {
        let lowercasedSearchedPokemon = searchedPokemon.lowercased()
        guard let appendedURL = baseURL?.appendingPathComponent(lowercasedSearchedPokemon) else {
            NSLog("Could not consturct URL.")
            completion(NSError())
            return
        }
        
        URLSession.shared.dataTask(with: appendedURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching search results.")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("Could not get data.")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let searchResult = try jsonDecoder.decode(PokemonModel.self, from: data)
                self.pokemon = searchResult
                Model.shared.pokemon = self.pokemon
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
