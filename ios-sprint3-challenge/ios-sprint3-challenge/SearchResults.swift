
import Foundation


struct SearchResult: Codable {
    
    let name: String
    let id: Int
    
    
    struct SearchResults: Codable {
        let results: [SearchResult]
    }
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
    }
}
