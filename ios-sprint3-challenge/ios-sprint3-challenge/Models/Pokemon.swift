import Foundation
import UIKit

struct Pokemon: Codable {
    let abilities: [String]
    let types: [String]
    let id: Int
    let name: String
    let sprites: [String]
    let sprite: String // sprites.front should return a URL String
    var isSaved = "False"
    
    enum CodingKeys: String, CodingKey {
        case sprite = "front_default"
        case abilities
        case types
        case id
        case name
        case sprites
        
        
    }
}
