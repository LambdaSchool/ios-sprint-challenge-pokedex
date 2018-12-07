import Foundation
import UIKit

class PokedexTableViewCell: UITableViewCell {
    static let reuseIdentifier = "pokedex cell"
    
    @IBOutlet var pokemonName: UILabel!
    
    @IBOutlet var pokemonSprite: UIImage!
    
}
