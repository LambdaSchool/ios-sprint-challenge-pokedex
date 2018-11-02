import Foundation

struct SearchResult: Codable {
    var name: String
    var id: String
    var abilities: String
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case abilities = "abilities"
        case type = "type"
    }
}

struct ResultsList: Codable {
    let results: [SearchResult]
}
