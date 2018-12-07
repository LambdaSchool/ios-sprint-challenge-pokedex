import Foundation

class Poke {
    static let endpoint = "https://pokeapi.co/api/v2/pokemon"
    
    static func searchForCharacters(with searchTerm: String, resultType: String, completion: @escaping ([Character]?, Error?) -> Void) {
        
        guard let baseURL = URL(string: endpoint)
            else {
                fatalError("Unable to construct baseURL")
        }
        
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL to components")
        }
        let searchQueryItems = URLQueryItem(name: "pokemon", value: searchTerm)
        let resultItemOne = URLQueryItem(name: "id", value: resultType)
        let resultItemTwo = URLQueryItem(name: "type", value: resultType)
        let resultItemThree = URLQueryItem(name: "ability", value: resultType)
        let resultItemFour = URLQueryItem(name: "sprintes", value: resultType)
        urlComponents.queryItems = [searchQueryItems, resultItemOne, resultItemTwo, resultItemThree, resultItemFour]
        
        guard let searchURL = urlComponents.url else {
           fatalError("Unable to recompose components")
        }
        var request = URLRequest(url: searchURL)
        request.httpMethod = "Get"
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            data, _, error in
            guard error == nil, let data = data else {
                if let error = error {
                    NSLog("Error fetching data: \(error)")
                }
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let searchResults = try jsonDecoder.decode(CharacterSearchResults.self, from: data)
                let characters = searchResults.pokemon
                completion(characters, nil)
            } catch {
                NSLog("Unable to decode data into character: \(error)")
                completion(nil, error)
            }
        }
        dataTask.resume()
    }
}
