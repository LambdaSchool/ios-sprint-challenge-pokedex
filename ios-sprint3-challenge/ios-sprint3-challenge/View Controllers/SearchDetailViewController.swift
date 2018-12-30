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
                return
            }
            //print(searchResults!)
            //self.searchResultsController.searchResult?.results.append(searchResults!)
            //print(self.searchResultsController.searchResult?.results)
            DispatchQueue.main.async {
                let result = searchResults! //self.searchResultsController.searchResult?.results
                POKEAPI.shared.searchResult.append(result)
                print(result.id!)
                print(result.abilities![0].ability?.name)
                self.searchViewLabel.text = result.name
                self.resultNameLabel.text = result.name
                self.resultIdLabel.text = "ID: \(result.id!)"
                self.resultTypesLabel.text = "Types: \(result.types![0].type!.name!)"
                self.resultAbilitiesLabel.text = "Abilities: \(result.abilities![0].ability!.name!)"
                self.spriteImage.loadImageFrom(url: URL(string: result.sprites?.frontDefault ?? "https://via.placeholder.com/128x201?text=Cover%20Image%20Unavailable")!)
                self.saveButton.titleLabel?.text = "Save Pokemon to Pokedex"
            }
            
        }
    }

    
    
}
