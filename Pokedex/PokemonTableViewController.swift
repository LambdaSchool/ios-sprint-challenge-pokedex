import UIKit

class PokemonTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return pokemonController.pokedex.count
        return 1
    }
    
    let reuseIdentifier = "pokecell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        // let pokemon = pokemonController.pokedex[indexPath.row]
        
        // cell.textLabel?.text = pokemon.name
        
        return cell
    }
    
    
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let pokemon = pokemonController.pokedex[indexPath.row]
//            pokemonController.deletePokemon(pokemon: pokemon)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
//
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        guard let destination = segue.destination as? PokemonDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        
        //   destination.pokemonController = pokemonController
        //    destination.pokemon = pokemonController.pokedex[indexPath.row]
    }
}
