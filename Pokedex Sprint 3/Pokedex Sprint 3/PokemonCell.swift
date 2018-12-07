import UIKit

class PokemonCell: UITableViewCell {
    static let reuseIdentifier = "pokemon cell"
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var IDLabel: UILabel!
    @IBOutlet var abilityLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var image: UIImage!
}
