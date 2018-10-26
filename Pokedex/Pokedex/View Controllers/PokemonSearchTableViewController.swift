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
//    var pokemons = [Pokemon]()  // fix this later to array of other pokemon Allpokemon
    var unfilteredPokemon = [Pokemon]()
    var searchedResults: [Result] = []

    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Model.shared.fetch {
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
            Model.shared.fetch(pokemonName: result.name)
            for pokemon in Model.shared.pokemonList {
                if !pokemon.name.contains(searchText.lowercased()) {
                    guard let indexPath = Model.shared.pokemonList.firstIndex(of: pokemon) else {return}
                    Model.shared.pokemonList.remove(at: indexPath)
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
            return Model.shared.pokemonList.count
        }
        return Model.shared.pokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        let pokemon: Pokemon
        if isFiltering() {
            pokemon = Model.shared.pokemonList[indexPath.row]
        } else {
            pokemon = Model.shared.pokemon[indexPath.row]
        }
        cell.detailTextLabel!.text = pokemon.name
        ImageLoader.fetchImage(from: URL(string: "\(pokemon.sprites.frontDefault)")) { (image) in
            guard let image = image else {return}
            DispatchQueue.main.async {
 //               cell.contentImageView.image = image
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let pokemon: Pokemon
                if isFiltering() {
                    pokemon = Model.shared.pokemonList[indexPath.row]
                } else {
                    pokemon = Model.shared.pokemonList[indexPath.row]
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
