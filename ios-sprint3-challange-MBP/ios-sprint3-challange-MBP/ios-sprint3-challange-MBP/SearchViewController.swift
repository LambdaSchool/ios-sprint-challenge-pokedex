import UIKit

class SearchViewController: UIViewController {

    var pokemon: Pokemon?
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func saveButton(_ sender: Any) {
        
    }
    func updateViews() {
        if let pokemon = Model.shared.pokemon {
            
            nameLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
            typeLabel.text = pokemon.types.first?.type.name
            abilitiesLabel.text = pokemon.abilities.first?.ability.name
            // imageView.image = pokemon.
            
        } else {
            title = "Pokemon Search"
            nameLabel.text = ""
            idLabel.text = ""
            typeLabel.text = ""
            abilitiesLabel.text = ""
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
      
    }
    

}
