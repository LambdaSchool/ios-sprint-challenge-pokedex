import UIKit

class MainTableViewController: UITableViewController {


    var searchAPI = SearchAPI()
   
    
   // @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.numberOfItems()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = Model.shared.pokemon(at: indexPath.row).name

        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let pokemon = Model.shared.pokemons[indexPath.row]
                Model.shared.delete(pokemons: pokemon)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
        
        // MARK: - Navigation
        
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
                
                // let pokemon = Model.shared.pokemon(at: indexPath.row)
                
                destination.pokemon = Model.shared.pokemon(at: indexPath.row)
                
                
            
                
            }
}
}

