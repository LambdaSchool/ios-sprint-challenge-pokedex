import Foundation

class Pokemon: Codable, FirebaseItem {
    
    var name: String
    var id: Int
    //var types: [String]
    //var abilities: [String]
    var recordIdentifier: String = ""
    
    init(name: String, id: Int) {
        // let types = types[0] ?? ""
        // let abilities = abilities[0] ?? ""
        (self.name, self.id ) = (name, id)
    }
}

//,self.types, self.abilities
//, [types], [abilities]
//types: [String?], abilities: [String?]
