
import Foundation
import UIKit

class SavedPokemonTVC:UITableViewController
{
	override func viewWillAppear(_ animated: Bool) {
		tableView.reloadData()
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return App.controller.savedPokemon.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
		cell.textLabel!.text = App.controller.savedPokemon[indexPath.row].name
		return cell
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? PokemonDetailVC {
			dest.poke = App.controller.savedPokemon[tableView.indexPathForSelectedRow?.row ?? 0]
		}
	}
}
