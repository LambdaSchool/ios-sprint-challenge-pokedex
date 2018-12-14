import UIKit

class DetailViewController: UIViewController, UISearchBarDelegate {

    var pokemon: Pokemon?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var pokemonView: UIImageView!
    @IBAction func save(_ sender: Any) {
        guard let pokemon = pokemon else {return}
        guard let name = nameLabel.text, !name.isEmpty else {return}
        Model.shared.addPokemon(pokemon: pokemon)
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        searchBar.text = ""
        
        Model.shared.search(for: searchTerm) { (error) in
            if error == nil {
                DispatchQueue.main.async {
                    updateViews()
                }
            }
        }
    }

    func updateViews() {
        
    }
}

