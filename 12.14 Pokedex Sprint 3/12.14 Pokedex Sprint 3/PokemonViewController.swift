import UIKit

class PokemonViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameLabelSame: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitesLabel: UILabel!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    @IBAction func savePokemon(_ sender: Any) {
        // save search bar text to model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBarOutlet.delegate = self
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        searchBar.text = ""
        searchBar.placeholder = searchTerm
        
        PokemonModel.shared.performSearch(with: searchTerm) { (error) in
        
            if error == nil {
                DispatchQueue.main.async {
//                    self.view.reloadData()
//                    updateViews()
                    var pokeName = PokemonModel.shared.poke(at: indexPath.row)
                    self.nameLabel.text = pokeName
                }
            }
        }
    }
}

