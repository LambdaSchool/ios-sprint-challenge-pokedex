import UIKit

class PokemonSearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    @IBAction func addPokemonButtonTapped(_ sender: Any) {
        
        
        
        
        navigationController?.popViewController(animated: true)
    }
    
}
