import Foundation
import UIKit

class PokeDexTableViewCell: UITableViewCell {
    static let reuseIdentifier = "pokedex cell"
    
    @IBOutlet var pokemonName: UILabel!
    
    @IBOutlet var pokemonSprite: UIImage!
    
}
