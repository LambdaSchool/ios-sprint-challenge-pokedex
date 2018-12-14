import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var pokemonDetailName: UILabel!
    
    @IBOutlet weak var pokemonDetailID: UILabel!
    
    @IBOutlet weak var pokemonDetailTypes: UILabel!
    
    @IBOutlet weak var pokemonDetailAbilities: UILabel!
    
    @IBOutlet weak var pokemonDetailImageView: UIImageView!
    
    // End of making outlets
    
    @IBOutlet weak var detailVCTitle: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
