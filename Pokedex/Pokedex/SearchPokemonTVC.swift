
import Foundation
import UIKit

class SearchPokemonTVC:UITableViewController, UISearchBarDelegate
{

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let query = searchBar.text, query != "" else {return}
		App.controller.query(query) { error in
			if error == nil {
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		}
		self.tableView.reloadData()
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return App.controller.searchedPokemon.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
		cell.textLabel!.text = App.controller.searchedPokemon[indexPath.row].name
		return cell
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? PokemonDetailVC {
			dest.poke = App.controller.searchedPokemon[tableView.indexPathForSelectedRow?.row ?? 0]
		}
	}
}
