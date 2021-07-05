import Foundation

struct PokemonSearchResults: Codable {
    var results: [Pokemon] {
        didSet {
            Model.shared.pokemon = self.results
        }
    }
}
