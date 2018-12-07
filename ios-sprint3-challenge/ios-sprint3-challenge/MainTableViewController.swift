import UIKit

class MainTableViewController: UITableViewController {


    var searchViewController = SearchViewController()
   
    
    @IBOutlet weak var mainNameLabel: UILabel!
    
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
        return searchViewController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { fatalError("no cell") }
        
        let searchResult = Model.shared.pokemon(at: indexPath.row)
        //searchViewController.searchResults[indexPath.row]
        
        
        cell.nameLabel.text = searchResult.name
        cell.abilitiesLabel.text = searchResult.abilities
        cell.idLabel.text = searchResult.id.hashValue
        cell.typeLabel.text = searchResult.types
        //            cell.textLabel?.text = searchResult.title
        //            cell.detailTextLabel?.text = searchResult.creator
        //
        return cell
    

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
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        Model.shared.deletePokemon(at: indexPath) {
            self.tableView.reloadData()
        }
    }
    
    
  //  if segue.identifier = "celldetail"
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let indexPath = tableView.indexPathsForSelectedRows else { return }
            guard let destination = segue.destination as? SearchDetailViewController else { return }

}
}

