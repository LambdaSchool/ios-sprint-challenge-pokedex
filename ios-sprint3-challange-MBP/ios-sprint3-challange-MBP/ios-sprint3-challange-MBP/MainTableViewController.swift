import UIKit

class MainTableViewController: UITableViewController {

    var searchAPI = SearchAPI()
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.numberOfPokemons()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PokemonCell else { fatalError("no cell") }
        let pokemon = Model.shared.pokemons[indexPath.row]
        cell.pokemonNameLabel.text = pokemon.name.capitalized
        guard let url = URL(string: pokemon.sprites?.frontDefault ?? "No Picture"),
              let imageData = try? Data(contentsOf: url) else { return cell }
        cell.pokemonView.image = UIImage(data: imageData)

        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                Model.shared.deletePokemon(at: indexPath)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    
        // MARK: - Navigation ( WE REALLY DON'T NEED SEGUE, WORKING FINE WITHOUT IT )
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "Search" {
                guard let indexPath = tableView.indexPathForSelectedRow
                    else {return}
                let destination = segue.destination as! SearchViewController
                let pokemon = Model.shared.pokemon(at: indexPath.row)
                destination.pokemon = pokemon
            }
            else if segue.identifier == "Detail" {
                let destination = segue.destination as! SearchDetailViewController
                guard let indexPath = tableView.indexPathForSelectedRow else { return }
                destination.pokemon = Model.shared.pokemons[indexPath.row]
            }
}
}

