import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {

    var pokemon: Pokemon?
    var pokemonController: PokemonController?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonSearchBar.delegate = self
        
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions
    @IBAction func savePokemon(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        
        pokemonController?.createPokemon(pokemon)
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = pokemonSearchBar.text, !searchText.isEmpty else { return }
        pokemonSearchBar.text = ""
        
        pokemonController?.searchForPokemon(searchText:searchText.lowercased(), completion: { (_, pokemon) in
            guard let pokemon = pokemon else {
                
                return
            }
            
            self.pokemon = pokemon
            self.pokemonController?.imageLoader(pokemon: pokemon, completion: { (_, pokemon) in
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                }
            })
        })

    }
    
    private func updateViews() {
        guard isViewLoaded, let pokemon = pokemon else {
            title = "Pokemon Search"
            nameLabel.text = " "
            idLabel.text = " "
            typeLabel.text = " "
            abilityLabel.text = " "
            saveButton.isEnabled = false
            return
        }
        title = pokemon.name
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        typeLabel.text = "Types: \(pokemon.typesString)"
        abilityLabel.text = "Abilities: \(pokemon.abilityString)"
        saveButton.isEnabled = true
        if let imageData = pokemon.imageData {
            pokemonImageView.image = UIImage(data: imageData)
        } else {
            pokemonImageView.isHidden = true
        }
    }

}
