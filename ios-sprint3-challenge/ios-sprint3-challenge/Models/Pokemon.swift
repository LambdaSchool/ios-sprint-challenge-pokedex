import Foundation
import UIKit

struct Pokemon: Codable {
    let abilities: [String]
    let forms: [String]
    let id: Int
    let name: String
    let sprites: [String]
    let spriteFront: String // sprites.front should return a URL String
    
    enum CodingKeys: String, CodingKey {
        case spriteFront = "front_default"
        case abilities
        case forms
        case id
        case name
        case sprites
        
        
    }
}
