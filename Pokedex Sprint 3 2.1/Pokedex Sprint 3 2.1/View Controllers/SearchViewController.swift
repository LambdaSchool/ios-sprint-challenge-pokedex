import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    var pokemon = PokemonController.shared.pokemon
    
    @IBOutlet weak var searchPokiBar: UISearchBar!
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var savedButtonOutlet: UIButton!
    
    @IBAction func SaveButtonPressed(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        
        PokemonController.shared.addPokemon(pokemon: pokemon)
        
        navigationController?.popToRootViewController(animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // updateviews
    }
    



}
