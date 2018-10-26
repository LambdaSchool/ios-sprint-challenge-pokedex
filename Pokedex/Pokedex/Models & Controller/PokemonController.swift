import Foundation

class PokemonController {
    
    var pokemon: Pokemon?
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    var pokedex: [Pokemon] = []
    
    func searchPokemon(name: String, completion: @escaping (Error?) -> Void){
        let requestURL = baseURL.appendingPathComponent(name)
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error searching pokemon info from server \(error)")
                completion(NSError())
                return
            }
            guard let data = data else {
                NSLog("No data")
                completion(NSError())
                return
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            do{
                let newPokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                print(newPokemon)
                self.pokemon = newPokemon
                completion(nil)
            } catch {
                NSLog("Error decoding pokemon: \(error)")
                completion(nil)
                return
            }
            }.resume()
    }
    func savePokemon(pokemon: Pokemon?){
        guard let pokemon = pokemon else {return}
        pokedex.append(pokemon)
    }
    func deletePokemon(pokemon: Pokemon){
        guard let index = pokedex.index(of: pokemon) else {return}
        pokedex.remove(at: index)
    }
}
