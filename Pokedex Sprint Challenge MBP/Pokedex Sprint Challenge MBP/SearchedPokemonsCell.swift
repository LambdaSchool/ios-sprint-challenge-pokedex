

import UIKit

class SearchedPokemonsCell: UITableViewCell {
    
    static let reuseIdentifier = "searchedcell"
    
    @IBOutlet weak var searchedPokeNameLabel: UILabel!
    
    @IBOutlet weak var searchedPokeIDLabel: UILabel!
    
    @IBOutlet weak var searchedPokeTypesLabel: UILabel!
    
    @IBOutlet weak var searchedPokeAbilitiesLabel: UILabel!
    
    @IBOutlet weak var searchedPokeSpriteView: UIImageView!
    
}
