import Foundation
import UIKit

struct Pokemon: Codable {
    let abilities: [String]
    let forms: [String]
    let id: Int
    let name: String
    let sprites: String // sprites.front should return a URL String
    
    enum CodingKeys: String, CodingKey {
        case front = "front_default"
        
    }
}
