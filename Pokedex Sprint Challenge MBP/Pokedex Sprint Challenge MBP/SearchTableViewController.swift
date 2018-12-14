

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
        
        // Set the delegate
        searchBarOutlet.delegate = self
    }

    // MARK: - Table view data source

    // Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.numberOfPokemons
    }

    // Cell contents
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchedPokemonsCell.reuseIdentifier, for: indexPath) as? SearchedPokemonsCell else {
            fatalError("Unable to retrieve and cast cell")
        }
        
        // Get the right pokemon
        let pokemon = Model.shared.findPokemon(at: indexPath)

        // Configure the cell...
        
        cell.searchedPokeNameLabel.text = pokemon.name
        cell.searchedPokeIDLabel.text = "ID: \(pokemon.id)"
        cell.searchedPokeTypesLabel.text = "Types: \(pokemon.types)"
        cell.searchedPokeAbilitiesLabel.text = "Abilities: \(pokemon.abilities)"
        
        // Get a url, try to load image data from that URL
        guard let url = URL(string: pokemon.sprites.frontFemale), let imageData = try? Data(contentsOf: url) else { return cell }
        
        cell.searchedPokeSpriteView?.image = UIImage(data: imageData)

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
