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
                    self.idLabel.text = "ID: \(pokemon.id)"
                    self.typesLabel.text = "Types: \(pokemon.types)"
                    self.abilitiesLabel.text = "Abilities: \(abilitiesArray)"
                    guard let url = URL(string: pokemon.sprites.frontDefault), let imageData = try? Data(contentsOf: url) else { return }
                    self.pokemonImage.image = UIImage(data: imageData)
                }
                
                completion(nil)
                return
            } catch {
                NSLog("Error decoding JSON: \(error)")
                
                DispatchQueue.main.sync {
                    self.nameLabel.text = "Can't Find That Pokemon."
                }
                
                completion(error)
                return
            }
        }
        .resume()
    }
    
    func searchPokemon(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        guard let searchPokemon = searchBar.text, !searchPokemon.isEmpty else { return }
        
        searchBar.text = nil
        
        performSearch(for: searchPokemon) { (error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.nameLabel.text = self.pokemon?.name.capitalized
                }
            }
        }
    }
}
