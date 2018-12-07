import Foundation

class PokemonNetworkingClient{
    
    
    
    static func searchForPokemon(with searchTerm: String, completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let url = "https://pokeapi.co/api/v2/pokemon\(searchTerm)"

        guard let baseURL = URL(string: url)
            else {
                fatalError("Unable to construct baseURL")
        }
        

        guard let urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }

        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        

        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        

        let dataTask = URLSession.shared.dataTask(with: request) {

            data, _, error in
            
 
            guard error == nil, let data = data else {
                if let error = error {
                    NSLog("Error fetching data: \(error)")
                    completion(nil, error)
                }
                return
            }
            

            do {

                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

                let searchResults = try jsonDecoder.decode(PokemonSearchResults.self, from: data)
                let pokemon = searchResults.results

                completion(pokemon, nil)
                
            } catch {
                NSLog("Unable to decode data into people: \(error)")
                completion(nil, error)

            }
        }
        
        dataTask.resume()
    }
}

