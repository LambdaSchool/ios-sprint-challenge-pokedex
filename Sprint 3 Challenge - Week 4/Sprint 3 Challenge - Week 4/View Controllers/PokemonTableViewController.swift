import UIKit

class PokemonTableViewController: UITableViewController, UISearchBarDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        Model.shared.updateHandler = { self.tableView.reloadData() }
        
    }
    
    // Work to do when this object is released back to memory
    deinit {
        // We're cleaning up after ourselves
        Model.shared.updateHandler = nil
    }
    
    // We need the search functionality and a responsive table to the search as it's used.
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty
            else { return }
        Model.shared.search(for: searchTerm)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.numberOfPokemon()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonSearchTableViewCell.reuseIdentifier, for: indexPath) as? PokemonSearchTableViewCell
            else {
                fatalError("Unable to retrieve and cast cell")
        }
        
        // get the right person
        let person = Model.shared.pokemon(at: indexPath.row)
        
        // fill out the cell labels
        cell.pokemonNameLabel.text = pokemon.name
        cell.idLabel.text = "ID: \(pokemon.id)"
        cell.typesLabel.text = "Types: \(pokemon.types)"
        cell.abilitiesLabel.text = "Abilities: \(pokemon.abilities)"
        
        return cell
    }
}
