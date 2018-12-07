import Foundation

class Pokemon: Codable, FirebaseItem {
    
    var name: String
    var id: String
    var types: String
    var abilities: [String]
    var recordIdentifier: String = ""
    
    init(name: String, id: String, types: String?, abilities: String?) {
        let types = types ?? ""
        let abilities = abilities ?? ""
        (self.name, self.id,self.types, self.abilities ) = (name, id, types, [abilities])
    }
}
