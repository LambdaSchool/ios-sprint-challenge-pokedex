import UIKit

//struct tempPoke {
//    let category: String
//    let name: String
//}

class PokemonSearchTableViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)

    var searchedResults: [Result] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Pokemon"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Model.shared.fetchAll {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        searchedResults = Model.shared.allPokemon.filter({( result : Result) -> Bool in
            return result.name.lowercased().contains(searchText.lowercased())
        })
        for result in searchedResults {
            Model.shared.fetchEachPokemon(pokemonName: result.name)
            for pokemon in Model.shared.searchPokemon {
                if !pokemon.name.contains(searchText.lowercased()) {
                    guard let indexPath = Model.shared.searchPokemon.firstIndex(of: pokemon) else {return}
                    Model.shared.searchPokemon.remove(at: indexPath)
                }
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return Model.shared.searchPokemon.count
        }
        return Model.shared.pokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! PokemonCell
//        cell.delegate = self
        
        let pokemon: Pokemon
        
        if isFiltering() {
            pokemon = Model.shared.searchPokemon[indexPath.row]
        } else {
            pokemon = Model.shared.pokemon[indexPath.row]
        }
        
        cell.nameLabel!.text = pokemon.name
        ImageLoader.fetchImage(from: URL(string: "\(pokemon.sprites.frontDefault)")) { (image) in
            guard let image = image else {return}
            DispatchQueue.main.async {
                cell.contentImageView.image = image
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let pokemon: Pokemon
                if isFiltering() {
                    pokemon = Model.shared.searchPokemon[indexPath.row]
                } else {
                    pokemon = Model.shared.pokemon[indexPath.row]
                }

                let controller = segue.destination as! PokemonDetailViewController
 //               controller.detailtempPoke = tempPoke
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}

extension PokemonSearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
