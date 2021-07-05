import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

//       searchBar.delegate = self
    }
    
    // MARK: - Table view data source
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text, search.count > 0 else { return }
        
//        var resultType: ResultType!
//
//        SearchResultController.shared.performSearch(with: search, resultType: resultType) { (_) in
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//                }
//            }
        }
//

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return SearchResultController.shared.searchResults.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)

       let searchResult = SearchResultController.shared.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.name
        cell.detailTextLabel?.text = searchResult.id

        return cell
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
   
//    let addSegueIdentifier = "searchSegue"
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let searchResultsController = segue.destination as? ListTableViewController else { fatalError("Segue destination failed")
//
//        }
//
//        guard let identifier = segue.identifier
//            else { fatalError("No segue identifier provided") }
//
//        switch identifier {
//        case addSegueIdentifier:
//            ListTableViewController.indexPath = nil
//
//        case addSegueIdentifier:
//            guard let indexPath = tableView.indexPathForSelectedRow
//                else { fatalError("Unable to retrieve selected index path") }
//            ListTableViewController.indexPath = indexPath
//
//        default:
//            fatalError("Unknown segue identifier: \(identifier)")
//        }
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tableView.reloadData()
//    }
    

    
    // swipe to delete
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        // Update model then refresh view
        
        if (editingStyle == .delete){
            SearchResultController.shared.searchResults.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
}
}
}
