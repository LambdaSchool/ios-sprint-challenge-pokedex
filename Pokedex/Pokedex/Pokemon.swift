import Foundation

// https://pokeapi.co/docs/v2.html/
struct Pokemon: Codable  {
    let name: String
    let ID: Int
    let ability: String
    let type: String
}
