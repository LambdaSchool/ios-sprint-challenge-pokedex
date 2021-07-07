//  Copyright © 2019 Frulwinn. All rights reserved.

import Foundation

class Model {
    
    static let shared = Model()
    private init () {}
    
    //baseURL for api
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    //MARK: Properties
    var pokemon: Pokemon?
    var pokemons: [Pokemon] = []
    
    //MARK: Methods
    //count
    func numberOfPokemons() -> Int {
        return pokemons.count
    }
    
    //access pokemon at index
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        return pokemons[indexPath.row]
    }
    
    //add
    func addPokemon(pokemon: Pokemon) {
        pokemons.append(pokemon)
    }
    
    //delete
    func deletePokemon(at indexPath: IndexPath) {
        pokemons.remove(at: indexPath.row)
    }
    
    //update
    func updatePokemon(at indexPath: IndexPath) {
        let _ = pokemons[indexPath.row]
    }
    
    //getting data from api
    func search(for searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void ) {
        
        let requestURL = baseURL.appendingPathComponent(searchTerm)
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("There was a problem getting data from JSON: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else {
                NSLog("No data found")
                completion(nil, error)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                self.pokemon = pokemon
                completion(pokemon, nil)
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
}
