import UIKit

class SearchPokemonViewController: UIViewController, UISearchBarDelegate {
    
    var searchResult: Pokemon?
    
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
        
        pokemonSearchResultsController.performSearch(searchTerm: searchTerm) { _, _ in
            DispatchQueue.main.async {
                // [... code to update each label...]
            }
        }
    }
}

