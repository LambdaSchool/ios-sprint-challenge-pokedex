import Foundation

struct Pokemon: Codable {
    let name: String
//    let identifier: String
//    let types: String
//    let ability: String
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
}
