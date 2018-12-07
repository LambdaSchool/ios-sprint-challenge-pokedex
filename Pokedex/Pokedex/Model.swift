import Foundation

class Model {
    static let shared = Model()
    private init() {}
    
    typealias UpdateHandler = () -> Void
    var updateHandler: UpdateHandler? = nil
    
    var characters: [Character] = [] {
        didSet {
            DispatchQueue.main.async {
                self.updateHandler?()
            }
        }
    }
    func numberOfCharacters() -> Int {
        return characters.count
    }
    
    //Fix this
    func search(for string: String) {
        Poke.searchForCharacters(with: string, resultType: string) { characters, error in
            if let error = error {
                NSLog("Error fetching people: \(error)")
                return
            }
            
            self.characters = characters ?? []
        }
    }
}
