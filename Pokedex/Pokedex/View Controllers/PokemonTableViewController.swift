import UIKit
import AVKit
//import AVFoundation

class PokemonTableViewController: UITableViewController {
    
    var pokemonController = PokemonController()
//    var musicPlayer: AVPlayer

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Model.shared.fetchAll {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonCell
        let record = Model.shared.pokemons[indexPath.row]
        
        cell.nameLabel.text = record.name
        cell.idLabel.text = String(record.id)
        
        ImageLoader.fetchImage(from: URL(string: record.sprites.frontDefault)) { image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.contentImageView.image = image
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        Model.shared.pokemons.remove(at: indexPath.row)
//        pokemonController.writeToFile()    // add persistence
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? PokemonDetailViewController else { return }
        destination.pokemonController = pokemonController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        destination.pokemon = pokemonController.pokedex[indexPath.row]
    }
    
    
}
