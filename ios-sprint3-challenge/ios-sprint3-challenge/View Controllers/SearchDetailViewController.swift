import Foundation
import UIKit

class SearchDetailViewController: UIViewController, UISearchBarDelegate {
    
    
   
    
    @IBOutlet var searchViewLabel: UILabel!
    
    @IBOutlet var searchField: UISearchBar!
    
    @IBOutlet var resultNameLabel: UILabel!
    @IBOutlet var resultIdLabel: UILabel!
    @IBOutlet var resultTypesLabel: UILabel!
    @IBOutlet var resultAbilitiesLabel: UILabel!
    
    
    @IBOutlet weak var spriteImage: UIImageView!
    
    @IBOutlet var saveButton: UIButton!
    
    @IBAction func saveToPokedex(_ sender: Any) {
        guard !POKEAPI.shared.searchResult.isEmpty else { return }
        POKEAPI.saveToPokedex(pokemon: POKEAPI.shared.searchResult[0])
        print(POKEAPI.shared.savedPokemon)
        POKEAPI.shared.searchResult.removeAll()
        print(POKEAPI.shared.searchResult)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.delegate = self
        searchViewLabel.text = "PokemonSearch"
        resultNameLabel.text = ""
        resultIdLabel.text = ""
        resultTypesLabel.text = ""
        resultAbilitiesLabel.text = ""
        saveButton.titleLabel?.text = ""
        spriteImage.image = nil
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchField.text, !searchTerm.isEmpty else { return }
        
        POKEAPI.searchForPokemon(with: searchTerm) { (searchResults, error) in
            if let error = error {
                NSLog("Error fetching results: \(error)")
                DispatchQueue.main.async {
                    self.resultNameLabel.text = "NO MATCHES FOUND."
                }
                return
            }
            
            DispatchQueue.main.async {
                let result = searchResults!
                POKEAPI.shared.searchResult.append(result)
                self.searchViewLabel.text = result.name
                self.resultNameLabel.text = result.name
                self.resultIdLabel.text = "ID: \(result.id!)"
                self.resultTypesLabel.text = "Types: \(POKEAPI.makeTypesString(for: result))"
                self.resultAbilitiesLabel.text = "Abilities: \(POKEAPI.makeAbilitiesString(for: result))"
                self.spriteImage.loadImageFrom(url: URL(string: result.sprites?.frontDefault ?? "https://via.placeholder.com/128x201?text=Cover%20Image%20Unavailable")!)
                self.saveButton.titleLabel?.text = "Save Pokemon to Pokedex"
            }
            
        }
    }

    
    
}
