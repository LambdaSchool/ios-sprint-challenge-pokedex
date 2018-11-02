import UIKit

class PokemonTableViewController: UITableViewController {
    
    var pokemon: Pokemon?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if pokemon != nil {
            return PokemonController.shared.pokedex.count
        } else {
            return 1
        }
    }
    
    let reuseIdentifier = "pokecell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if pokemon != nil {
            
        let pokemon = PokemonController.shared.pokedex[indexPath.row]
        cell.textLabel?.text = pokemon.name
        return cell
            
        } else {
        return cell
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let pokemon = PokemonController.shared.pokedex[indexPath.row]
            PokemonController.shared.deletePokemon(pokemon: pokemon)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destination = segue.destination as? PokemonDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        
        if pokemon != nil {
        
        let pokemon = PokemonController.shared.pokedex[indexPath.row]
        destination.pokemon = pokemon
            
        }
    }
}
