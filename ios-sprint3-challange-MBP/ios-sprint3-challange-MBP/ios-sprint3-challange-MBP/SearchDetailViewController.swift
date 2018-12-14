import Foundation
import UIKit

class SearchDetailViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
        var pokemons: [Pokemon]? = []
        var pokemon: Pokemon?
        let searchAPI = SearchAPI()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let pokemon = pokemon else { return }
        
        nameLabel.text = pokemon.name
        idLabel.text = String(pokemon.id)
        abilitiesLabel.text = pokemon.abilities[0].ability.name
        typeLabel.text = pokemon.types[0].type.name
    }
    
        func searchBarSearchButtonClicked(_  searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
    guard let searchTerm = searchBar.text, !searchTerm.isEmpty
        else {return}
        
            let resultType = ResultType.self
            
            searchAPI.performSearch(with: searchTerm, resultType: resultType) { ([Pokemon]?, error) in
               
                if let error = error {
                    NSLog("Error fetching data: \(error)")
                    return
            }
                self.pokemons = self.pokemons ?? []
                }
    }


            
            //resultType = ResultType// for testing
            
//            Model.shared.search(with: searchTerm) { () -> Void in
//
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//                }
//            }

        
    

}
