import UIKit

class SearchPokemonViewController: UIViewController, UISearchBarDelegate {

    static let reuseIdentifer = "ResultCell"
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    @IBOutlet weak var pokemonIDLabel: UILabel!
    
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    
    @IBAction func savePokemon(_ sender: Any) {
        pokemonSearchResultsController.pokemonSearchResults.append(pokemonSearchResult!)
        
        // Pop back into previous view after saving pokemon
        navigationController?.popViewController(animated: true)
    }
    
    var pokemonSearchResult: Pokemon?
    
    // Access our model and save having to write a few characters...
    let pokemonSearchResultsController = PokemonSearchResultsController()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Fix later
    @IBOutlet weak var searchResultsVCTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        searchBar.text = ""
        searchBar.placeholder = searchTerm
        
        func updateSearchResults() {
            
            if let pokemonSearchResult = pokemonSearchResult {
                
                guard let urlString = pokemonSearchResult.sprites?.frontDefault else { return }
                
                guard let imageURL = URL(string: urlString), let imageData = try? Data(contentsOf: imageURL) else { fatalError("Couldn't obtain image.")}
                self.pokemonNameLabel.text = pokemonSearchResult.name
                self.pokemonIDLabel.text = "ID: \(pokemonSearchResult.id)"
                
                self.pokemonTypesLabel.text = "Types: "
                
                self.pokemonAbilitiesLabel.text = "Abilities: "
                
               self.pokemonSpriteImageView?.image = UIImage(data: imageData)
            }
        }
        
        pokemonSearchResultsController.performSearch(searchTerm: searchTerm) { _ in
            DispatchQueue.main.async {
               // self.pokemonSearchResult = PokemonSearchResultsController.shared.pokemonSearchResults[IndexPath]
                updateSearchResults()
            }
        }
    }
}

