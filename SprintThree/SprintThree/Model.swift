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
        //let pokemonURL = baseURL.appendingPathComponent("pokemon")
        
        //You don't need to use URLComponenets or URLQueryItems
//        let components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
//      let searchQueryItem = URLQueryItem(name: "pokemon", value: searchTerm)
//      urlComponents?.queryItems = [searchQueryItem]
        
//        guard let requestURL = URLComponents?.url else {
//            NSLog("wasn't able to construct URL")
//            completion(NSError())
//            return
//        }
        
        //create get request
        var request = URLRequest(url: baseURL)
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
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                let pokemons = searchResults.pokemon
                completion(searchResults.pokemon, nil)

            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(nil, error)
                return
            }
        }
        dataTask.resume()
    }
}
