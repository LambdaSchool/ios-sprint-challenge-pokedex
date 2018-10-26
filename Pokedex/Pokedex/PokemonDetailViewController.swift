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
    
    @IBAction func savePokemon(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        
        pokemonController?.createPokemon(pokemon)
        navigationController?.popViewController(animated: true)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = pokemonSearchBar.text, !searchText.isEmpty else {
            return
        }
        
        pokemonController?.searchForPokemon(searchText:searchText.lowercased(), completion: { (_, pokemon) in
            guard let pokemon = pokemon else { return }
            
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.updateViews()
            }
            
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
        
        idLabel.text = "ID: \(pokemon.id)"
        typeLabel.text = "Types: \(pokemon.typesString)"
        abilityLabel.text = "Abilities: \(pokemon.abilityString)"
        saveButton.isEnabled = true
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
