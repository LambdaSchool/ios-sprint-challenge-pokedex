import UIKit

class SearchDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var searchViewController = SearchViewController()
        
        func searchBarSearchButtonClicked(_  searchBar: UISearchBar) {
            //        guard let searchTerm = searchBar.text, !searchTerm.isEmpty
            //            else {return}
            
            guard let searchTerm = searchBar.text, searchTerm.count > 0 else {return}
            
            var resultType: ResultType!
            
            resultType = ResultType.name // for testing
            
            searchViewController.performSearch(with: searchTerm, resultType: resultType) { (_) in
                
                DispatchQueue.main.async {
                  //  tableView.reloadData()
                }
            }
        }
        
    
        }
        

