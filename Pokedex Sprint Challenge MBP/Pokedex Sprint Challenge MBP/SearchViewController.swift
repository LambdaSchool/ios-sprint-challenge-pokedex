
import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchedNameLabel: UILabel!
    @IBOutlet weak var searchedIDLabel: UILabel!
    @IBOutlet weak var searchedTypesLabel: UILabel!
    @IBOutlet weak var searchedAbilitiesLabel: UILabel!
    @IBOutlet weak var searchedSpriteView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        Model.shared.updateHandler = { self.viewDidLoad() }
        
        // Set the delegate
        searchBar.delegate = self
        
        searchedNameLabel.textColor = .white
        searchedIDLabel.textColor = .white
        searchedTypesLabel.textColor = .white
        searchedAbilitiesLabel.textColor = .white
        
    }
    
    deinit {
        Model.shared.updateHandler = nil
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        searchBar.resignFirstResponder()
        
        // Make sure it has text and that it is not empty
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
    
        searchBar.text = ""
        searchBar.placeholder = searchTerm
    
        Model.shared.search(for: searchTerm)
        
        // Call our model's search function to display results of what the user searched for

        DispatchQueue.main.async {
            self.viewDidLoad()
                    
            guard let pokemon = self.pokemon else { return }
                    
            self.navigationItem.title = pokemon.name
            self.searchedNameLabel.text = pokemon.name
            self.searchedIDLabel.text = "ID: \(pokemon.id)"
            self.searchedTypesLabel.text = "Types: \(pokemon.types)"
            self.searchedAbilitiesLabel.text = "Abilities: \(pokemon.abilities)"
                    
            guard let url = URL(string: pokemon.sprites.frontDefault), let imageData = try? Data(contentsOf: url) else { return }
                    
            self.searchedSpriteView?.image = UIImage(data: imageData)
            
        }
    }
}

