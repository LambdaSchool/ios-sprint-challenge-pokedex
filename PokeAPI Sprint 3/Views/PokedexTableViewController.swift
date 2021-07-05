import UIKit

class PokedexTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PokedexModel.shared.savedPokemon.count
    }
    
    // Display Pokemon in individual cells from savedPokemon[]
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath)
        
        // Access the name of the saved Pokemon in our model and set it to the cell's text.
        cell.textLabel?.text = PokedexModel.shared.savedPokemon[indexPath.row].name
        
        return cell
    }
    
    // Allow the user to remove saved Pokemon
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        PokedexModel.shared.removePokemon(indexPath: indexPath)
        
        // Make sure the user sees the update on the views
        tableView.reloadData()
    }
    
    // MARK: - Navigation | Segue - to the Detail View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        guard let destination = segue.destination as? PokemonDetailViewController else { return }
        
        destination.savedPokemon = PokedexModel.shared.savedPokemon[indexPath.row]
    }
}
