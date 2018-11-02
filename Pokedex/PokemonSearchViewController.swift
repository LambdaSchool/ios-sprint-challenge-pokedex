import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    var pokemon: Pokemon?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    
    @IBAction func saveToButtonTapped(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        updateViews()
    }
    
    func updateViews() {
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name
            idLabel.text = "#\(pokemon.id)"
            abilityLabel.text = "\(pokemon.abilities)"
            typeLabel.text = "\(pokemon.types)"
        } else {
            nameLabel.text = ""
            idLabel.text = ""
            abilityLabel.text = ""
            typeLabel.text = ""
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text, !search.isEmpty else {return}
        
        PokemonController.shared.performSearch(with: search) {
       
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
}
