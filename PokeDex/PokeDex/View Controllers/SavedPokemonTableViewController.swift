import UIKit

class SavedPokemonTableViewController: UITableViewController {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.savedPokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedPokemonCell", for: indexPath)
        
        cell.textLabel?.text = Model.shared.savedPokemon[indexPath.row].name
        
//        cell.imageView?.image = Model.shared.savedPokemon[indexPath.row].sprites[0]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow
            else { return }
        guard let destination = segue.destination as? PokemonDetailViewController
            else { return }
        
        destination.pokemon = Model.shared.pokemonAt(index: indexPath.row)
    }
    
}
