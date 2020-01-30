import UIKit

class SearchViewController: UIViewController {
    
    
    // MARK: - Properties
    
    var delegate: PokeDexTableViewController?
    var pokemonController: PokemonController?
    var searchResultPokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var buttonTextLabel: UIButton!
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search.delegate = self
        clearViews()
    }

    
    // MARK: - Functions
    
    // Clears View Before Search
    func clearViews() {
        pokemonNameLabel.text = ""
        pokemonIdLabel.text = ""
        pokemonTypesLabel.text = ""
        pokemonAbilitiesLabel.text = ""
        buttonTextLabel.isEnabled = false
    }
    
    func updateViews() {
        guard let pokemon = searchResultPokemon else {
            print("No Pokemon Set")
            return
        }
        pokemonNameLabel.text = pokemon.name
        pokemonIdLabel.text = "ID: " + String(pokemon.id)
        buttonTextLabel.isEnabled = true
        pokemonController?.fetchImage(at: pokemon.sprites.front_default, completion: { (result) in
            guard let image = result else { return }
            DispatchQueue.main.async {
                self.pokemonImage.image = image
            }
        })
        pokemonTypesLabel.text = "Types: " + pokemon.types.map { $0.type.name }.joined(separator: ", ")
        pokemonAbilitiesLabel.text = "Abilities: " + pokemon.abilities.map { $0.ability.name }.joined(separator: ", ")
    }

    
    // MARK: - IBActions
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemonController = pokemonController,
            let pokemon = searchResultPokemon else { return }
        pokemonController.savedPokemon.append(pokemon)
        delegate?.tableView.reloadData()
        _ = navigationController?.popToRootViewController(animated: true)
    }
}


// MARK: - Extentions

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
        
        print("Searching for search term \(searchTerm)")
        
        pokemonController?.fetchPokemon(for: searchTerm) { (result) in
           
            guard let result = result else {
                print("Error with result")
                return
            }
            
            DispatchQueue.main.async {
                self.searchResultPokemon = result
            }
        }
    }
}

