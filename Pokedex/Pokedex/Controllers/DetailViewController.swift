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
        guard let pokemon = pokemon else { return }
        
        DispatchQueue.main.async {
            self.navigationItem.title = pokemon.name
            self.nameLabel.text = pokemon.name
            self.idLabel.text = "ID: \(pokemon.id)"
            
            let types: [String] = pokemon.types.map { $0.type.name }
            self.typesLabel.text = "Types: \(types.joined(separator: ", "))"
            
            let abilities: [String] = pokemon.abilities.map { $0.ability.name }
            self.abilitiesLabel.text = "Abilities: \(abilities.joined(separator: ", "))"
            
            guard let url = URL(string: pokemon.sprites.frontDefault),
                let imageData = try? Data(contentsOf: url) else { return }
            
            self.pokemonView.image = UIImage(data: imageData)
        }
    }
    
}

