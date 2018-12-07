import Foundation

struct SearchResult: Codable {
    
    let name: String
    let id: Int
    let abilities: String
    let types: String
init(name: String, id: Int, abilities: String, types: String) {
        
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
    }

    struct SearchResults: Codable {
        let results: [SearchResult]
    }

//enum CodingKeys: String, CodingKey {
//    case name = "name"
//    case id = "id"
//}
}
