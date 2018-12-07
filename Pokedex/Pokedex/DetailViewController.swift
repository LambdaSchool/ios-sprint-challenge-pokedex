import UIKit

class DetailViewController: UIViewController, UISearchBarDelegate {
    var character: Character?
    
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func save(_ sender: Any) {
    }
    
    @IBOutlet weak var spriteView: UIImageView!
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        <#code#>
    }
    
}

