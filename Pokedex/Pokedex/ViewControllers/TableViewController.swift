import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return Model.shared.numberOfpokemon()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as? TableViewCell else {
            fatalError("Can not load cell.")
        }

        let pokemon = Model.shared.savePokemon(at: indexPath)
        cell.nameLabel.text = pokemon.name.capitalized
        
        guard let url = URL(string: pokemon.sprites.frontDefault),
            let imageData = try? Data(contentsOf: url) else { return cell }
        cell.pokemonImage.image = UIImage(data: imageData)

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
            // Delete the row from the data source
            Model.shared.removePokemon(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
    }
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
            let pokemon = Model.shared.savePokemon(at: indexPath)
            destinationVC.pokemon = pokemon
    }
}
