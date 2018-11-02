import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

       searchBar.delegate = self
    }

    // MARK: - Table view data source

//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let search = searchBar.text, search.count > 0 else { return }
//        var resultType: ResultType!
//        let index = segmentedControl.selectedSegmentIndex
//
//        if index == 0 {
//            resultType = 
//        }
//    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return SearchResultController.shared.searchResults.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)

       let searchResult = SearchResultController.shared.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator

        return cell
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    

}

