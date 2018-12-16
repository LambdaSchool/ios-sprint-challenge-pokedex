

import UIKit

class SavedPokemonsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    // Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.numberOfSavedPokemons
    }

    // Cell contents
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get the cell and cast it
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedPokemonsCell.reuseIdentifier, for: indexPath) as? SavedPokemonsCell else {
            fatalError("Unable to retrieve and cast cell")
        }
        
        // Get the right pokemon
        let pokemon = Model.shared.savedPokemon(at: indexPath)

        // Configure the cell...
        
        cell.savedPokeNameLabel.text = pokemon.name
        
        // Get a url, try to load image data from that URL
        guard let url = URL(string: pokemon.sprites.frontDefault), let imageData = try? Data(contentsOf: url) else { return cell }
        
        cell.savedPokeSpriteView.image = UIImage(data: imageData)

        return cell
    }


    // Support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        Model.shared.remove(at: indexPath)
        tableView.reloadData()
    }



    // MARK: - Navigation

    // Segue to detail view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        
        // Unwrap the segue's destination and get an index path
        guard let destinationDVC = segue.destination as? DetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        
        // Get the search results for the index path
        let pokemon = Model.shared.findPokemon(at: indexPath)
        
        // Pass the selected object to the new view controller.
        destinationDVC.pokemon = pokemon
        
    }


}
