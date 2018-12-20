import UIKit

class PokemonDetailViewController: UIViewController {
    
    var savedPokemon: Pokemon?
    
    // Detail View Controller Outlets
    // Pokemon Name
    @IBOutlet weak var pokemonDetailName: UILabel!
    // Pokemon ID
    @IBOutlet weak var pokemonDetailID: UILabel!
    // Pokemon Type(s)
    @IBOutlet weak var pokemonDetailTypes: UILabel!
    // Pokemon Abilities
    @IBOutlet weak var pokemonDetailAbilities: UILabel!
    // Pokemon Image/Sprite
    @IBOutlet weak var pokemonDetailImageView: UIImageView!
    
    // TODO: Complete or delete
    @IBOutlet weak var detailVCTitle: UINavigationItem!
    
    // Code that might be removed later.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
