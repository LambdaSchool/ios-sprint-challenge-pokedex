import Foundation

class Model {
    
    //singleton
    static let shared = Model()
    private init () {}
    
    //baseURL for api
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    //var
    var pokemon: Pokemon?
    var pokemons: [Pokemon] = []
    
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
        let pokemon = pokemons[indexPath.row]
    }
    
    //accessing api process
    func search(for searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void ) {
        let requestURL = baseURL.appendingPathComponent(searchTerm)
        
        //create get request
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        //fetching data
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
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
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                self.pokemon = pokemon
                print("\(pokemon)")
                completion(pokemon, nil)

            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(nil, error)
                return
            }
        }
        dataTask.resume()
    }
}
