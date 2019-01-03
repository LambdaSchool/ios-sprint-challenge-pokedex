import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    var pokemon = Model.shared.pokemon
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var savePokemonButton: UIButton!
    
    @IBAction func saveButtonAction(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        Model.shared.addPokemon(pokemon: pokemon)
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonSearchBar.delegate = self
    }
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func performSearch(for searchTerm: String, completion: @escaping (Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Could not load URL results: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Bad URL data request.")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                var typesArray: [String] = []
                for types in pokemon.types {
                    typesArray.append(types.type.name)
                }
                
                var abilitiesArray: [String] = []
                for ability in pokemon.abilities {
                    abilitiesArray.append(ability.ability.name)
                }
                
                self.pokemon = pokemon
                
                DispatchQueue.main.async {
                    self.navigationController?.title = pokemon.name
                    self.nameLabel.text = pokemon.name
                    self.
                }
                
                completion(nil)
                return
            } catch {
                NSLog("Error decoding JSON: \(error)")
            }
        }
    }
}
