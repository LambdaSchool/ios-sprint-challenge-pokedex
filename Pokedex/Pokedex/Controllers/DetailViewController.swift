//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class DetailViewController: UIViewController, UISearchBarDelegate {

    //MARK: Properties
    var pokemon: Pokemon?
    
    @IBOutlet weak var pokemonView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBAction func save(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        guard let name = nameLabel.text, !name.isEmpty else { return }
        Model.shared.addPokemon(pokemon: pokemon)
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        <#code#>
    }
    
    func updateViews() {
        
    }
    
}

