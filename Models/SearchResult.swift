import Foundation

struct SearchResults: Codable{
    let id: Int
    let name: String
    let types: [TypeElement]
    let abilities: [Ability]
    let sprites: Sprites
}
