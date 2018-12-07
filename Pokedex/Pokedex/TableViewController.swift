import UIKit

class TableViewController: UITableViewController {

    //outlets
    @IBAction func search(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Model.shared.updateHandler = { self.tableView.reloadData()}
    }
    deinit {
        Model.shared.updateHandler = nil
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.numberOfCharacters()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let character = Model.shared.character(at: indexPath.row)

        return cell
    }
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathsForSelectedRows else { return }
        guard let destination = segue.destination as? DetailViewController else { return }
        let character = Model.shared.characters
        //need to fix this
        destination.characterLabel = character
    }
}
