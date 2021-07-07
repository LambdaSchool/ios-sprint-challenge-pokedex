
import UIKit

class DetailViewController: UIViewController {
    
    var searchViewController = SearchViewController()
    
    var pokemon: Pokemon?
    
    @IBOutlet weak var detailSpriteView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailIDLabel: UILabel!
    @IBOutlet weak var detailTypesLabel: UILabel!
    @IBOutlet weak var detailAbilitiesLabel: UILabel!
    

    
    // Called just before view controller appears on-screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let pokemon = pokemon else { return }
        
        // Populate the labels and image
        
        var onePokemonTypeArray : [String] = []
        var onePokemonAbilityArray : [String] = []
        for each in pokemon.types {
            onePokemonTypeArray.append(each.type.name)
        }
        for each in pokemon.abilities {
            onePokemonAbilityArray.append(each.ability.name)
        }
        
        self.navigationItem.title = pokemon.name
        detailNameLabel.text = pokemon.name
        detailIDLabel.text = "ID: \(pokemon.id)"
        detailTypesLabel.text = "Types: " + "\(onePokemonTypeArray.joined(separator: ", "))"
        detailAbilitiesLabel.text = "Abilities: \(onePokemonAbilityArray.joined(separator: ", "))"

        
        // Get a url, try to load image data from that URL
        guard let url = URL(string: pokemon.sprites.frontDefault), let imageData = try? Data(contentsOf: url) else { return }
        
        detailSpriteView.image = UIImage(data: imageData)
    }
    
}
