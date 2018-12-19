import UIKit

class DetailViewController: UIViewController, UISearchBarDelegate {

    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
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
        
        Model.shared.search(for: searchTerm.lowercased()) { (pokemon, error) in
            if let pokemon = pokemon, error == nil {
                self.pokemon = pokemon
                DispatchQueue.main.async {
                    self.updateViews()
                }
            }
        }
    }

    func updateViews() {
        guard let pokemon = pokemon else {return}
        
        navigationItem.title = pokemon.name
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        
        //possibly fix?
        typesLabel.text = "Types: \(pokemon.types)"
        abilitiesLabel.text = "Abilities: \(pokemon.abilities)"
        
        //image
        guard let url = URL(string: pokemon.sprites.frontDefault),
            let imageData = try? Data(contentsOf: url) else {return}
        
        pokemonView.image = UIImage(data: imageData)
    }
}

