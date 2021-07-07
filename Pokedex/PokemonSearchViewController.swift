import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    let pokemonController = PokemonController()
    var pokemon: Pokemon?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController.performSearch(with: searchTerm) { (error) in
            
            if let error = error {
                NSLog("Error when searching: \(error)")
                return
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let pokemon = pokemon else {return}
        
        pokemonNameLabel.text = pokemon.name
        pokemonIDLabel.text = "#\(pokemon.id)"
        pokemonTypeLabel.text = "\(pokemon.types)"
        pokemonAbilitiesLabel.text = "\(pokemon.abilities)"
        
    }


@IBAction func addPokemonButtonTapped(_ sender: Any) {
    
    
    
    
    navigationController?.popViewController(animated: true)
}

}
