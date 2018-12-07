import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Model.shared.updateHandler = { self.tableView.reloadData() }
    }
    
    // work to do when this object is released back to memory
    //Cleaning up after ourselves...kind of like setting a text field to an empty string.
    deinit {
        Model.shared.updateHandler = nil
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        Model.shared.search(for: searchTerm)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.numberOfPokemon()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.reuseIdentifier, for: indexPath) as? PokemonCell
            else {
                fatalError("Unable to retrieve and cast cell")
        }
        
        //Get person
        let pokemon = Model.shared.pokemon(at: indexPath.row)
        
        cell.nameLabel.text = pokemon.name
        cell.IDLabel.text = pokemon.ID
        cell.abilityLabel.text = pokemon.ability
        cell.typeLabel.text = pokemon.types
        cell.image?.images = pokemon.sprites
        
        return cell
    }
    
}
