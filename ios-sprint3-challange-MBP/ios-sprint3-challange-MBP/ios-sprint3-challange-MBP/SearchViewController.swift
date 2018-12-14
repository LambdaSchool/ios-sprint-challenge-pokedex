import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        searchBar.delegate = self
    }
    var pokemon: Pokemon?
    var searchAPI = SearchAPI()
    var pokemons: [Pokemon] = []
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func saveButton(_ sender: Any) {
        
    }
    
    
    func searchBarSearchButtonClicked(_  searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty
            else {return}
        
        
        
        searchAPI.performSearch(with: searchTerm) { ([Pokemon]?, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
           
        }
    }
    
    func updateViews() {
        if let pokemon = Model.shared.pokemon {
            
            nameLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
            typeLabel.text = pokemon.types.first?.type.name
            abilitiesLabel.text = pokemon.abilities.first?.ability.name
            // imageView.image = pokemon.
            
        } else {
            title = "Pokemon Search"
            nameLabel.text = ""
            idLabel.text = ""
            typeLabel.text = ""
            abilitiesLabel.text = ""
        }
    }
    
    

}
