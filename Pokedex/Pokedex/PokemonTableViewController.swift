import UIKit

class PokemonTableViewController: UITableViewController {

    let pokemonController = PokemonController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokedex.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        let pokemon = pokemonController.sortedPokedex[indexPath.row]
        
        cell.textLabel?.text = pokemon.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemon = pokemonController.sortedPokedex[indexPath.row]
            pokemonController.deletePokemon(pokemon)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
    



    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddPokemonSegue" {
            let destinationVC = segue.destination as! PokemonDetailViewController
            
            destinationVC.pokemonController = pokemonController
        } else if segue.identifier == "ShowPokemonSegue" {
            guard let destinationVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let pokemon = pokemonController.sortedPokedex[indexPath.row]
            
            destinationVC.pokemonController = pokemonController
            destinationVC.pokemon = pokemon
        }
    }
    

}
