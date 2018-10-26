import UIKit

struct tempPoke {
    let category: String
    let name: String
}

class PokemonSearchTableViewController: UITableViewController, UISearchControllerDelegate {
    var pokemonController: PokemonController?
    let searchController = UISearchController(searchResultsController: nil)
    var filteredPokemon = [AllPokemon]()  // pokemons
    
    var filteredtempPoke = [tempPoke]()
    var pokemons = [tempPoke]()  // fix this later to array of other pokemon
    var unfilteredPokemon = [AllPokemon]()
    var pokemon: Pokemon? {
        didSet {
            //updateViews()
            pokemonController?.savePokemon(pokemon: pokemon)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tempory to test searching features need to switch to API
        pokemons = [
            tempPoke(category:"Fire", name:"Charmander"),
            tempPoke(category:"Fire", name:"Charmeleon"),
            tempPoke(category:"Fire", name:"Charizard"),
            tempPoke(category:"Water", name:"Squirtle"),
            tempPoke(category:"Water", name:"Wartortle"),
            tempPoke(category:"Water", name:"Blastoise"),
            tempPoke(category:"Grass", name:"Bulbasaur"),
            tempPoke(category:"Grass", name:"Ivysaur"),
            tempPoke(category:"Grass", name:"Venusaur"),
            tempPoke(category:"Electric", name:"Pikachu")
        ]
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Pokemon"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
//    func updateSearchResults(for searchController: UISearchController) {
//        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
//            filteredPokemon = unfilteredPokemon.filter { pokemon in
//                return .lowercased().contains(searchText.lowercased())
//            }
//        }
//    }

    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredtempPoke = pokemons.filter({( tempPoke: tempPoke ) -> Bool in
            return tempPoke.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredtempPoke.count
        }
        return pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        let tempPoke: tempPoke
        if isFiltering() {
            tempPoke = filteredtempPoke[indexPath.row]
        } else {
            tempPoke = pokemons[indexPath.row]
        }
        cell.textLabel!.text = tempPoke.name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let tempPoke: tempPoke
                if isFiltering() {
                    tempPoke = filteredtempPoke[indexPath.row]
                } else {
                    tempPoke = pokemons[indexPath.row]
                }
                
                let controller = segue.destination as! PokemonDetailViewController
                controller.detailtempPoke = tempPoke
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
