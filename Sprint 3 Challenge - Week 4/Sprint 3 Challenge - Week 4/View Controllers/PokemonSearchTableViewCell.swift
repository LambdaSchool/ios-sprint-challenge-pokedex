import UIKit

class PokemonSearchTableViewCell: UITableViewCell {
    static let reuseIdentifier = "cell"
    
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typesLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    @IBAction func savePokemon(_ sender: UIButton) {
    }
}
