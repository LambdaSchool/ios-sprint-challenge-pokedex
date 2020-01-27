import Foundation

//// Name Element
//struct NameElement: Codable {
//    let name: String
//}
//
//// Abilities Model
//struct Abilities: Codable {
//    let ability: NameElement
//}
//
//// Types Model
//struct Types: Codable {
//    let type: NameElement
//}

// Pokemon Model
struct Pokemon: Codable {
    let id: Int
    let name: String
//    let types: [Types]?
//    let abilities: [Abilities]?
}
