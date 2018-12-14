import Foundation

class Model {
    
    //singleton
    static let shared = Model()
    private init () {}
    
    //baseURL for api
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    //var
    var pokemons: [Pokemon] = []
}
