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
                NSLog("Could not load results: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Bad data request.")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                var typeArray : [String] = []
                for each in pokemon.types {
                    typeArray.append(each.type.name.capitalized)
                }
                var abilityArray : [String] = []
                for each in pokemon.abilities {
                    abilityArray.append(each.ability.name.capitalized)
                }
                
                self.pokemon = pokemon
                
                DispatchQueue.main.async {
                    self.navigationItem.title = pokemon.name.capitalized
                    self.nameLabel.text = pokemon.name.capitalized
                    self.idLabel.text = "ID: \(pokemon.id)"
                    self.typesLabel.text = "Types: \(typeArray)"
                    self.abilitiesLabel.text = "Abilities: \(abilityArray)"
                    guard let url = URL(string: pokemon.sprites.frontDefault), let imageData = try? Data(contentsOf: url) else { return }
                    self.pokemonImage.image = UIImage(data: imageData)
                }
                
                completion(nil)
                return
            } catch {
                NSLog("Error decoding JSON: \(error)")
                
                DispatchQueue.main.async {
                    self.typesLabel.text = "Can't find that Pokemon."
                }
                
                completion(error)
                return
            }
            }
            .resume()
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
