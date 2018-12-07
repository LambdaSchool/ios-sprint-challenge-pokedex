
import UIKit

struct SearchResult: Codable {
    var name: String
    var id: Int
    var type: String
    var abilities: String
    var img: UIImage

    // initializer
    init(name: String, id: Int, type: String, abilities: String, img: UIImage) {
        self.name = name
        self.id = id
        self.type = type
        self.abilities = abilities
        self.img = img
    }
    
}

// Object representing JSON at the highest level
struct SearchResults: Codable {
    let results: [SearchResult]
}
