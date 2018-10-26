import UIKit

struct tempPoke {
    let category: String
    let name: String
}

class PokemonSearchTableViewController: UITableViewController, UISearchControllerDelegate {
    var pokemonController: PokemonController?
    let searchController = UISearchController(searchResultsController: nil)
    var filteredPokemon = [Pokemon]()
    
//    var filteredtempPoke = [tempPoke]() //delete later
    var pokemons = [Pokemon]()  // fix this later to array of other pokemon Allpokemon
    var unfilteredPokemon = [Pokemon]()
    var pokemon: Pokemon? {
        didSet {
            //updateViews()
            pokemonController?.savePokemon(pokemon: pokemon)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tempory to test searching features need to switch to API
//        pokemons = [
//            tempPoke(category:"Fire", name:"Charmander"),
//            tempPoke(category:"Fire", name:"Charmeleon"),
//            tempPoke(category:"Fire", name:"Charizard"),
//            tempPoke(category:"Water", name:"Squirtle"),
//            tempPoke(category:"Water", name:"Wartortle"),
//            tempPoke(category:"Water", name:"Blastoise"),
//            tempPoke(category:"Grass", name:"Bulbasaur"),
//            tempPoke(category:"Grass", name:"Ivysaur"),
//            tempPoke(category:"Grass", name:"Venusaur"),
//            tempPoke(category:"Electric", name:"Pikachu")
//        ]
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Pokemon"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredPokemon = pokemons.filter({( pokemons: Pokemon ) -> Bool in
            return pokemons.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredPokemon.count
        }
        return pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        let pokemons: Pokemon
        if isFiltering() {
            pokemons = filteredPokemon[indexPath.row]
        } else {
//            pokemons = pokemons[indexPath.row]
        }
//        cell.textLabel!.text = pokemons.name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let pokemon: Pokemon
                if isFiltering() {
                    pokemon = filteredPokemon[indexPath.row]
                } else {
                    pokemon = pokemons[indexPath.row]
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
