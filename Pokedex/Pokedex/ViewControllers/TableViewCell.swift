import UIKit

class TableViewCell: UITableViewCell {

  static let reuseIdentifier = "pokemonCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
}
