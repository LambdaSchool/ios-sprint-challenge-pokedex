import UIKit

class SavedPokemonTableViewController: UITableViewController {
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.numberOfPokes()
    }
    
    // Cell contents
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedTableViewCell.reuseIdentifier, for: indexPath) as? SavedTableViewCell else { fatalError("Unable to dequeue pokemon cell") }
        
        let pokemon = Model.shared.poke(at: indexPath.row)
        cell.pokeNameSavedLabel.text = pokemon.name
        cell.pokeImageSavedView.image = pokemon.sprites
        
        return cell
    }
    
    // Delete a pokemon, update the model, and reload data
    override func tableView(_ tableViewPassedToUs: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        Model.shared.removePoke(at: indexPath) {
            self.tableView.reloadData()
        }
    }
    
    // Add a new poke, update the model, and reload data
    @IBAction func add() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SavedTableViewCell else { return }
        
        guard let name = cell.pokeNameSavedLabel.text, !name.isEmpty
            else { return }
        
        let image = cell.pokeImageSavedView.image
        
        let pokemon = Pokemon(
    }
}
