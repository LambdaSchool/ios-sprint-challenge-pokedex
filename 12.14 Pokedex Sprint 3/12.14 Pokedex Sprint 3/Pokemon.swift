import Foundation

struct Pokemon: Codable {
    let pokemonName: String
    let pokemonID: String
    let pokemonType: String
    let pokemonAbilities: String
    let pokemonImage: imageURLS
    
}

struct imageURLS: Codable {
    let name: String
    let url: String
    let ability: String
}

struct SearchResults: Codable {
    let results: [Pokemon]
}
