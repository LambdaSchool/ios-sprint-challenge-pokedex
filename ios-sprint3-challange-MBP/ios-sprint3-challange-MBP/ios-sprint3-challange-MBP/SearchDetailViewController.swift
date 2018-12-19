import Foundation
import UIKit

class SearchDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var imageDetailView: UIImageView!
    
        var pokemon: Pokemon?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let pokemon = pokemon else { return }
        
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(String(describing: pokemon.id))"
        abilitiesLabel?.text = "Ability: \(pokemon.abilities[0].ability.name.capitalized)"
        typeLabel?.text = "Type: \(pokemon.types[0].type.name.capitalized)"
        weightLabel.text = "Weight: \(pokemon.weight) hectograms"
        guard let url = URL(string: pokemon.sprites?.frontDefault ?? "No Picture"),
            let imageData = try? Data(contentsOf: url) else { return }
        imageView.image = UIImage(data: imageData)
    }
}

        
    


