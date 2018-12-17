import UIKit

class SearchPokemonViewController: UIViewController, UISearchBarDelegate {

    static let reuseIdentifer = "ResultCell"
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    @IBOutlet weak var pokemonIDLabel: UILabel!
    
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    
    @IBAction func savePokemon(_ sender: Any) {
        pokemonSearchResultsController.searchResults.append(searchResult!)
        
        // Pop back into previous view after saving pokemon
        // Doesn't work so far
        //NavigationController?.popViewController(animated: true)
    }
    
    var searchResult: Pokemon?
    
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
        
        func updateSearchBar() {
            
           // guard let imageURL = URL(string: (searchResult!.sprites.frontDefault)),            let imageData = try? Data(contentsOf: imageURL) else { fatalError("Couldn't obtain image.")}
            self.pokemonNameLabel.text = self.searchResult?.name
            self.pokemonIDLabel.text = "ID: \(self.searchResult!.id)"
            
            self.pokemonTypesLabel.text = "Types: "
            
            self.pokemonAbilitiesLabel.text = "Abilities: "
            
           // self.pokemonSpriteImageView?.image = UIImage(data: imageData)
        }
        
        pokemonSearchResultsController.performSearch(searchTerm: searchTerm) { _, _ in
            DispatchQueue.main.async {
                updateSearchBar()
            }
        }
    }
}

