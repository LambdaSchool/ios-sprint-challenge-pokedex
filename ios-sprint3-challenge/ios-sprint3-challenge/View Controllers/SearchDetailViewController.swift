import Foundation
import UIKit

class SearchDetailViewController: UIViewController, UISearchBarDelegate {
    
   let searchResultsController = POKEAPI()
    
    @IBOutlet var searchViewLabel: UILabel!
    
    @IBOutlet var searchField: UISearchBar!
    
    @IBOutlet var resultNameLabel: UILabel!
    @IBOutlet var resultIdLabel: UILabel!
    @IBOutlet var resultTypesLabel: UILabel!
    @IBOutlet var resultAbilitiesLabel: UILabel!
    
    
    @IBOutlet weak var spriteImage: UIImageView!
    
    @IBOutlet var saveButton: UIButton!
    
    @IBAction func saveToPokedex(_ sender: Any) {
        
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
            
            self.searchResultsController.searchResult = searchResults ?? []
            
            DispatchQueue.main.async {
                let result = self.searchResultsController.searchResult[0]
                
                self.searchViewLabel.text = result.name
                self.resultNameLabel.text = result.name
                self.resultIdLabel.text = "ID: \(String(result.id))"
                self.resultTypesLabel.text = "Types: \(result.types[1])"
                self.resultAbilitiesLabel.text = "Abilities: \(result.abilities[1])"
                self.spriteImage.image = #imageLiteral(resourceName: "1.png") // TESTIMAGE FOR NOW
                self.saveButton.titleLabel?.text = "Save Pokemon to Pokedex"
            }
            
        }
    }

    
    
}
