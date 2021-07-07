import UIKit
import Foundation

class SearchAPI {
    
    let endpoint = "http://pokeapi.co/api/v2/pokemon/"
   
    var pokemon: Pokemon?
    func performSearch (with searchTerm: String, completion: @escaping  (Error?) -> Void) {
    
        guard let baseURL = URL(string: endpoint) else { fatalError("Unable to construct baseURL") }
      let finalURL = baseURL.appendingPathComponent(searchTerm.lowercased())
       
        let dataTask = URLSession.shared.dataTask(with: finalURL) { data, _, error in
            guard error == nil, let data = data else {
                if let error = error {
                    NSLog("Error fetching data: \(error)")
                    completion(error)
                }
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let searchResults = try jsonDecoder.decode(Pokemon.self, from: data)
                self.pokemon = searchResults
                Model.shared.pokemon = self.pokemon
                print(searchResults)
                completion(nil)
                return
            } catch {
                NSLog("Unable to decode data \(error)")
                completion(nil)
                return
            }
        }
        dataTask.resume()
    }
}
