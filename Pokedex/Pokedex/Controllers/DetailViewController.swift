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
        searchBar.delegate = self
        updateViews()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        searchBar.text = ""
        
        
        Model.shared.search(for: searchTerm.lowercased()) { (pokemon, error) in
            if let pokemon = pokemon, error == nil {
                self.pokemon = pokemon
                DispatchQueue.main.async {
                    self.updateViews()
                }
            }
        }
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemon = pokemon else {
        title = "Pokemon Search"
            return
        }
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

