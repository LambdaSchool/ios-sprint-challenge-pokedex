//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class TableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.numberOfPokemons()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
        
        let pokemon = Model.shared.pokemon(at: indexPath)
        cell.textLabel?.text = pokemon.name
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
            //tableView.deleteRows(at: [indexPath], with: .fade)
        Model.shared.deletePokemon(at: indexPath)
        tableView.reloadData()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        
        let pokemon = Model.shared.pokemon(at: indexPath)
        destination.pokemon = pokemon
    }
}
