import UIKit

class PokeDexTableViewController: UITableViewController {

    
    // MARK: - Properties
    
    let pokemonController = PokemonController()
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - Tableview Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.savedPokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        cell.textLabel?.text = pokemonController.savedPokemon[indexPath.row].name

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected this \(indexPath)")
        let name = pokemonController.savedPokemon[indexPath.row].name
        print("Selected this Pokemon \(name)")
    }
   
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            guard let searchVC = segue.destination as? SearchViewController else { return }
            searchVC.pokemonController = self.pokemonController
            searchVC.delegate = self
        }
        if segue.identifier == "DetailSegue" {
            guard let detailVC = segue.destination as? DetailViewController else { return }
            guard let path = self.tableView.indexPathForSelectedRow else { return }
            let pokemonSelected = pokemonController.savedPokemon[path.row]
            detailVC.pokemonSent = pokemonSelected
        }
    }
}
