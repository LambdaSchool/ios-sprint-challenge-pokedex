import UIKit

class Search {
    
        
        func searchBarSearchButtonClicked(_  searchBar: UISearchBar) {
            //        guard let searchTerm = searchBar.text, !searchTerm.isEmpty
            //            else {return}
            
            guard let searchTerm = searchBar.text, searchTerm.count > 0 else {return}
            
            var resultType: ResultType!
            
            resultType = ResultType.name // for testing
            
            Search(with: searchTerm, resultType: resultType) { (_) in
                
                DispatchQueue.main.async {
                  //  tableView.reloadData()
                }
            }
        }
        
    
        }
        

