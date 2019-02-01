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
                var typeArray: [String] = []
                for each in pokemon(each.type.ability.name.capitalized)
            }
            
            self.pokemon = pokemon
        
    }

    }
}
