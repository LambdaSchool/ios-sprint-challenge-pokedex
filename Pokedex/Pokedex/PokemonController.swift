import Foundation

class PokemonController {
    
    private(set) var pokedex: [Pokemon] = []
    var sortedPokedex: [Pokemon] {
        return pokedex.sorted() { $0.name < $1.name}
    }
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    //MARK: - CRUD
    func createPokemon(_ pokemon: Pokemon) {
        pokedex.append(pokemon)
    }
    
    func deletePokemon(_ pokemon: Pokemon) {
        guard let index = pokedex.index(of: pokemon) else { return }
        
        pokedex.remove(at: index)
    }
    
    // Create a dataTask to GET Pokemon
    func searchForPokemon(searchText: String, completion: @escaping (Error?, Pokemon?) -> Void) {
        var requestURL = baseURL.appendingPathComponent("pokemon")
        requestURL.appendPathComponent(searchText)
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error searching for Pokemon: \(error)")
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                NSLog("Data not sent")
                completion(NSError(), nil)
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                self.pokedex.append(pokemon)
                completion(nil, pokemon)
            } catch {
                NSLog("Coud not decode data: \(error)")
                completion(error, nil)
                return
            }
        }.resume()
    }
    
    func imageLoader(pokemon: Pokemon, completion: @escaping (Error?, Pokemon?) -> Void) {
        guard let requestURL = URL(string: pokemon.sprites.frontDefault) else {
            NSLog("Unable to obtain image")
            completion(NSError(), nil)
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching image: \(error)")
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned.")
                completion(NSError(), nil)
                return
            }
            
            pokemon.imageData = data
            completion(nil, pokemon)
            return
            
        }.resume()
    }
    
}
