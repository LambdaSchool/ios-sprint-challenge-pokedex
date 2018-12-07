import UIKit

struct Pokemon: Codable {
    let name: String
    let ID: String // MARK: Could be an Int...
    let type: String
    let abilities: String
    let sprite: String
    // UIImage doesn't conform to Codable
}

//struct Person: Codable {
//    let name: String
//    let birthYear: String // MARK: this is different from API docs
//    let height: String
//}
