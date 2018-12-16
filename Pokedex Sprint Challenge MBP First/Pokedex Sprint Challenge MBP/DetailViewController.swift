
import UIKit

class DetailViewController: UIViewController {
    
    var searchTableViewController = SearchTableViewController()
    
    var pokemon: Pokemon?
    
    @IBOutlet weak var detailSpriteView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailIDLabel: UILabel!
    @IBOutlet weak var detailTypesLabel: UILabel!
    @IBOutlet weak var detailAbilitiesLabel: UILabel!
    
    @IBAction func save(_ sender: Any) {
        
        guard let pokemon = pokemon else { return }
        
        Model.shared.add(pokemon: pokemon)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    // Called just before view controller appears on-screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let pokemon = pokemon else { return }
        
        // Populate the labels and image
        
        self.navigationItem.title = pokemon.name
        detailNameLabel.text = pokemon.name
        detailIDLabel.text = "ID: \(pokemon.id)"
        detailTypesLabel.text = "Types: \(pokemon.types)"
        detailAbilitiesLabel.text = "Abilities: \(pokemon.abilities)"

        
        // Get a url, try to load image data from that URL
        guard let url = URL(string: pokemon.sprites.frontDefault), let imageData = try? Data(contentsOf: url) else { return }
        
        detailSpriteView.image = UIImage(data: imageData)
    }
    
}
