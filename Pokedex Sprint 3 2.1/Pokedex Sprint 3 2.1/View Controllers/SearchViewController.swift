import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    typealias completionHandler = (Error?) -> Void
    var pokemon = PokemonController.shared.pokemon
    
    @IBOutlet weak var searchPokiBar: UISearchBar!
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var savedButtonOutlet: UIButton!
    
    @IBAction func SaveButtonPressed(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        
        PokemonController.shared.addPokemon(pokemon: pokemon)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchPokiBar.delegate = self
    }
    
    func performSearch(for searchTerm: String, completion: @escaping completionHandler) {
        
        let requestURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Base URL request: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Bad data request")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                var abilityArray: [String] = []
                for each in pokemon.abilities {
                abilityArray.append(each.ability.name.capitalized)
            }
                var typeArray: [String] = []
                for each in pokemon.abilities {
                    typeArray.append(each.ability.name.capitalized)
                }
                
                
            
            self.pokemon = pokemon
                DispatchQueue.main.async {
                    self.navigationItem.title = pokemon.name.capitalized
                    self.nameLabel.text = pokemon.name.capitalized
                    self.idLabel.text = "ID: \(pokemon.id)"
                    self.typesLabel.text = "Types: \(typeArray)"
                    self.abilitiesLabel.text = "Abilities: \(abilityArray)"
                    guard let url = URL(string: pokemon.sprites.frontDefault), let imageData = try? Data(contentsOf: url) else { return }
                    self.imagePokemon.image = UIImage(data: imageData)
                }
                
                completion(nil)
                return
            } catch {
                NSLog("Error decoding JSON: \(error)")
                DispatchQueue.main.async {
                    self.nameLabel.text = "Can't find that Pokemon."
                }
                completion(error)
                return
            }
        }.resume()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
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




































