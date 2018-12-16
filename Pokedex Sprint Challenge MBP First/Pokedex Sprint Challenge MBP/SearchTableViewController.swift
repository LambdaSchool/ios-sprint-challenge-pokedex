

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        
        // Set the delegate
        searchBarOutlet.delegate = self
        
        // Let the user know that data is loading
        let activity = UIActivityIndicatorView()
        activity.style = .gray
        // Start animating
        activity.startAnimating()
        // Set the title view to be the activity indicator
        navigationItem.titleView = activity
        
        refresh()
        
        /*
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

        // Set the delegate
        searchBarOutlet.delegate = self
        */
    }

    // MARK: - Table view data source

    // Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.numberOfPokemons
    }

    // Cell contents
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchedPokemonsCell.reuseIdentifier, for: indexPath) as? SearchedPokemonsCell else {
            fatalError("Unable to retrieve and cast cell")
        }
        
        // Get the right pokemon
        //let pokemon = Model.shared.findPokemon(at: indexPath)
        let pokemon = Model.shared.pokemon
        // Configure the cell...
        
        cell.searchedPokeNameLabel.text = pokemon?.name
        cell.searchedPokeIDLabel.text = "ID: \(pokemon?.id)"
        cell.searchedPokeTypesLabel.text = "Types: \(pokemon?.types)"
        cell.searchedPokeAbilitiesLabel.text = "Abilities: \(pokemon?.abilities)"
        
        // Get a url, try to load image data from that URL
        guard let url = URL(string: (pokemon?.sprites.frontDefault)!) else { return cell}
        guard let imageData = try? Data(contentsOf: url) else { return cell }
        
        cell.searchedPokeSpriteView?.image = UIImage(data: imageData)

        //cell.pokemon = pokemon
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        // Make sure it has text and that it is not empty
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        searchBar.text = ""
        searchBar.placeholder = searchTerm
        
        // Call our model's search function to display results of what the user searched for
        Model.shared.performSearch(for: searchTerm) { (error) in
            if error == nil {
                // On the main thread
                DispatchQueue.main.async {
                    
                    // Tell the table view to reload the data
                    // Reload when in our model it sets pokemon to the results
                    self.tableView.reloadData()
                }
            }

        }
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        
        // Unwrap the segue's destination and get an index path
        guard let destinationDVC = segue.destination as? DetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        
        // Get the search results for the index path
        let pokemon = Model.shared.findPokemon(at: indexPath)
        
        // Pass the selected object to the new view controller.
        destinationDVC.pokemon = pokemon
    }

    func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
            // When we are -done- with the request, we will re-enable the view
            self.navigationItem.titleView = nil
            // When you replace the titleView, it also deletes the title, so we need to reset it
            self.title = "Pokemon Search"
        }
    }
    
}
