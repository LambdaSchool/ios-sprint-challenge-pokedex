import UIKit

class SearchResultsTableViewCell: UITableViewCell {
    static let reuseIdentifier = "searchedpokecell"
    
    @IBOutlet weak var pokeNameLabel: UILabel!
    
    @IBOutlet weak var pokeIdLabel: UILabel!
    
    @IBOutlet weak var pokeTypesLabel: UILabel!
    
    @IBOutlet weak var pokeAbilitiesLabel: UILabel!
    
    @IBOutlet weak var pokeImageView: UIImageView!
    
    
}
