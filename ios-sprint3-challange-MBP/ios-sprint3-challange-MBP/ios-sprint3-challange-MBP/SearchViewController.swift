import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    var pokemon: Pokemon?
    var searchAPI = SearchAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButton(_ sender: Any) {
      
        Model.shared.addNewPokemon()
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_  searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty
            else {return}
        searchBar.text = ""
        
        searchAPI.performSearch(with: searchTerm) { (error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.updateViews()
            }
    }
    }
    
    func updateViews() {
       
        if let pokemon = Model.shared.pokemon {
        DispatchQueue.main.async {
           
            self.nameLabel.text = pokemon.name.capitalized
            self.idLabel?.text = "ID: \(pokemon.id)"
            self.typeLabel?.text = "Type: \(pokemon.types[0].type.name.capitalized)"
            self.abilitiesLabel?.text = "Ability: \(pokemon.abilities[0].ability.name.capitalized)"
            self.weightLabel.text = "Weight: \(pokemon.weight) hectograms"
            
            DispatchQueue.global().async {
                guard let url = URL(string: pokemon.sprites?.frontDefault ?? "No Picture"),
                    let imageData = try? Data(contentsOf: url) else { return }
                DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
                }
            }
            self.saveButton.isHidden = false
            self.navigationItem.title = pokemon.name.capitalized
        }
        
        } else {
            title = "Pokemon Search"
            nameLabel.text = ""
            idLabel.text = ""
            typeLabel.text = ""
            abilitiesLabel.text = ""
            weightLabel.text = ""
            saveButton.isHidden = true
        }
    }
}

