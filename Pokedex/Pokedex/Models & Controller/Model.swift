import Foundation
import WatchKit

class Model {
    static let shared = Model()
    private init() {}
    
    var pokemons: [Pokemon] = []
    var allPokemon: [Result] = []
    
    func fetch(completion: @escaping () -> Void = { }) {
        guard
            let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon"),
            let components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            else {
                fatalError("Unable to setup url and components")
        }
        
        guard let fetchURL = components.url else {
            fatalError("Cannot build request URL")
        }
        
        let dataTask = URLSession.shared.dataTask(with: fetchURL) { data, _, error in
            guard error == nil, let data = data else {
                NSLog("Could not run dataTask, url: \(fetchURL)")
                completion()
                return
            }
            
            do {
                let searchResults = try JSONDecoder().decode(AllPokemon.self, from: data)
                self.allPokemon = searchResults.results
            } catch {
                NSLog("Unable to decode data into Pokemon: \(error)")
                completion()
                return
            }
        }
        
        dataTask.resume()
    }
}
