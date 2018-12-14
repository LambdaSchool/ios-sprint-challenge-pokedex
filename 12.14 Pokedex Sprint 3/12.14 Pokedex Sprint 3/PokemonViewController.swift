import UIKit

class PokemonViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameLabelSame: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitesLabel: UILabel!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    @IBAction func savePokemon(_ sender: Any) {
        // save search bar pokemon to model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBarOutlet.delegate = self
    }
    
    func reloadData() {
        //updates pokemon
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        searchBar.text = ""
        searchBar.placeholder = searchTerm
        
        let resultType: ResultType! = .name
        nameLabel.text = resultType.map { $0.rawValue }
        nameLabelSame.text = resultType.map { $0.rawValue }
        
        SearchResultController.shared.performSearch(with: searchTerm, resultType: resultType) { (error) in
        
        if error == nil {
                DispatchQueue.main.async {
                    self.reloadData()
                }
            }
        }
    }
}

