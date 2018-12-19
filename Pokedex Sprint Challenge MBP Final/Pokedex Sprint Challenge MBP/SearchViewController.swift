
import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var searchedNameLabel: UILabel!
    @IBOutlet weak var searchedIDLabel: UILabel!
    @IBOutlet weak var searchedTypesLabel: UILabel!
    @IBOutlet weak var searchedAbilitiesLabel: UILabel!
    @IBOutlet weak var searchedSpriteView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var saveLabelOutlet: UILabel!
    
    @IBAction func save(_ sender: Any) {
        
        guard let pokemon = pokemon else { return }
        
        Model.shared.add(pokemon: pokemon)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    //var pokemon: Pokemon?
    var pokemon = Model.shared.pokemon
    var pokemons = Model.shared.savedPokemons
    var thePokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the delegate
        searchBar.delegate = self

        //saveButtonOutlet.isEnabled = false
        //self.saveButtonOutlet.setTitleColor(UIColor.white, for: .normal)
        self.saveButtonOutlet.setImage(nil, for: .normal)
        self.saveLabelOutlet.textColor = .white
        
    }
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func performSearch(for searchTerm: String, completion: @escaping (Error?) -> Void) {
        // PUT TOGETHER A URL(urlRequest) TO MAKE A REQUEST/dataTask
        let requestURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        // MAKE THE REQUEST/dataTask
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            // unwrap the error if we have one
            if let error = error {
                NSLog("Error fetching search results: \(error)")
                completion(error)
                return
            }
            // unwrap the data
            guard let data = data else {
                NSLog("Request didn't return valid data.")
                completion(NSError())
                return
            }
            // Make JSON decoder
            let jsonDecoder = JSONDecoder()
            // Convert from snake case
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            // Convert the data
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                
                var onePokemonTypeArray : [String] = []
                var onePokemonAbilityArray : [String] = []
                for each in pokemon.types {
                    onePokemonTypeArray.append(each.type.name)
                }
                for each in pokemon.abilities {
                    onePokemonAbilityArray.append(each.ability.name)
                }
                
                self.pokemon = pokemon
                
                DispatchQueue.main.async {
                    self.navigationItem.title = pokemon.name
                    self.searchedNameLabel.text = pokemon.name
                    self.searchedIDLabel.text = "ID: \(pokemon.id)"
                    self.searchedTypesLabel.text = "Types: " + "\(onePokemonTypeArray.joined(separator: ", "))"
                    self.searchedAbilitiesLabel.text = "Abilities: \(onePokemonAbilityArray.joined(separator: ", "))"
                    guard let url = URL(string: pokemon.sprites.frontDefault), let imageData = try? Data(contentsOf: url) else { return }
                    self.searchedSpriteView.image = UIImage(data: imageData)
                    
                    //self.saveButtonOutlet.setTitle("Save Pokemon", for: .normal)
                    
                    //guard let pokeBallURL = URL(string: "https://upload.wikimedia.org/wikipedia/en/3/39/Pokeball.PNG"), let imageDataPokeBall = try? Data(contentsOf: pokeBallURL) else { return }
                    //let buttonImage = UIImage(named: "https://upload.wikimedia.org/wikipedia/en/3/39/Pokeball.PNG")
                    let pokeBall = #imageLiteral(resourceName: "Pokeball")
                    self.saveButtonOutlet.setImage(pokeBall, for: .normal)
                    self.saveLabelOutlet.textColor = .black



                }
                
                completion(nil)
                return
            } catch {
                NSLog("Error decoding JSON: \(error)")
                completion(error)
                return
            }
        }
        .resume()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        // Make sure it has text and that it is not empty
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        searchBar.text = ""
        
        performSearch(for: searchTerm) { (error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.searchedNameLabel.text = self.pokemon?.name
                }

            }
        }
        
    }
}

// Call our model's search function to display results of what the user searched for
/*
 Model.shared.performSearch(for: searchTerm) { (error) in
 if error == nil {
 //DispatchQueue.main.async {
 
 guard let pokemon = self.pokemon else { return }
 
 self.navigationItem.title = pokemon.name
 self.searchedNameLabel.text = pokemon.name
 self.searchedIDLabel.text = "ID: \(pokemon.id)"
 self.searchedTypesLabel.text = "Types: \(pokemon.types)"
 self.searchedAbilitiesLabel.text = "Abilities: \(pokemon.abilities)"
 
 guard let url = URL(string: pokemon.sprites.frontDefault), let imageData = try? Data(contentsOf: url) else { return }
 
 self.searchedSpriteView?.image = UIImage(data: imageData)
 
 //}
 }
 }
 */
