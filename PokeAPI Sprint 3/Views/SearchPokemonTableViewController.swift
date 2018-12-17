import UIKit

class SearchPokemonTableViewController: UITableViewController, UISearchBarDelegate {
    
    var searchResult: Pokemon?
    
  // redundant
    // let pokemonSearchResultsController = PokemonSearchResultsController()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchResultTVCTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.numberOfPokemon
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)

        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        searchBar.text = ""
        searchBar.placeholder = searchTerm
        
        PokemonSearchResultsController.shared.performSearch(searchTerm: searchTerm) { _, _ in
            DispatchQueue.main.async {
                    self.tableView.reloadData()
            }
        }
    }
}

