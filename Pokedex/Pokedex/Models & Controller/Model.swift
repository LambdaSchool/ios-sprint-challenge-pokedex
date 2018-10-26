import Foundation

class Model {
    static let shared = Model()
    private init() {}
    
    var pokemons: [Pokemon] = []
    var pokemonList: [Pokemon] = []
    var allPokemon: [Result] = []
    
    func fetch(completion: @escaping () -> Void = { }) {
        guard let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")
            else { fatalError("Unable to set up url and components") }
        
//        guard let fetchURL = components.url else {
//            fatalError("Components could not construct proper search query")
//        }
        let dataTask = URLSession.shared.dataTask(with: baseURL) { data, _, error in
            
            guard error == nil,
                let data = data else {
                    NSLog("Unable to fetch data")
                    completion()
                    return
            }
            
            do {
                let searchResults = try JSONDecoder().decode(AllPokemon.self, from: data)
                self.allPokemon = searchResults.results
                completion()
            } catch {
                NSLog("Unable to decode data into news entries: \(error)")
                completion()
            }
        }
        dataTask.resume()
    }
}
