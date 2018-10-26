//import UIKit
//
//class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
//    var pokemonController: PokemonController?
//    let searchController = UISearchController(searchResultsController: nil)
//    var filteredPokemon = [Pokemon]()
//
//    @IBOutlet weak var searchBar: UISearchBar!
//    @IBOutlet weak var saveButton: UIBarButtonItem!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var idLabel: UILabel!
//    @IBOutlet weak var typeLabel: UILabel!
//    @IBOutlet weak var abilitiesLabel: UILabel!
//
//    var pokemon: Pokemon? {
//        didSet {
//            updateViews()
//            pokemonController?.savePokemon(pokemon: pokemon)
//        }
//    }
//    
//    @IBAction func saveAction(_ sender: Any) {
//        guard let pokemon = pokemon else { return }
//        pokemonController?.savePokemon(pokemon: pokemon)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        nameLabel.text = ""
////        idLabel.text = ""
////        typeLabel.text = ""
////        abilitiesLabel.text = ""
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search Pokemon"
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//        searchBar.delegate = self
////        searchController.delegate = self as? UISearchControllerDelegate
//    }
//
//    func updateViews() {
//        guard let pokemon = pokemon else { return }
//        let abilities = pokemon.abilities.map {$0.ability.name}.joined(separator: ", ")
//        let types = pokemon.types.map {$0.type.name}.joined(separator: ", ")
//        nameLabel.text = pokemon.name
//        idLabel.text = "ID: \(pokemon.id)"
//        typeLabel.text = "Types: \(types)"
//        abilitiesLabel.text = "Abilities: \(abilities)"
//        }
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print("searching SOMETHING")
//        guard let pokemon = searchBar.text else { return }
//        pokemonController?.searchPokemon(name: pokemon.lowercased(), completion: { (_) in
//            DispatchQueue.main.async {
//                self.pokemon = self.pokemonController?.pokemon
//                print("something fucking ELSE DAMN IT")
//            }
//        })
//    }
//
//    func searchBarIsEmpty() -> Bool {
//        return searchController.searchBar.text?.isEmpty ?? true
//    }
//
////    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
////        filteredPokemon = pokemonController?.pokedex.filter({( pokemon: Pokemon ) -> Bool in
////            return pokemon.name.lowercased().contains(searchText.lowercased())
////        })
////        tableView.reloadData()
////    }
//
//    func isFiltering() -> Bool {
//        return searchController.isActive && !searchBarIsEmpty()
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering() {
//            return filteredPokemon.count
//        }
//        guard let pokedex = pokemonController?.pokedex else { fatalError("bad pokemon") }
//        return pokedex.count
//    }
//
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)
////        let pokemon: Pokemon
////        if isFiltering() {
////            pokemon = filteredPokemon[indexPath.row]
////        } else {
////            pokemon = (pokemonController?.pokedex[indexPath.row])!
////        }
////        cell.textLabel!.text = pokemon.name
////
////        return cell
////    }
//
//}
//
//extension PokemonSearchViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
////        filterContentForSearchText(searchController.searchBar.text!)
//    }
//}
