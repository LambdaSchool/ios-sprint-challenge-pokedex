import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var viewController = ViewController()
    
    var pokemon: Pokemon?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let pokemon = pokemon else { return }
        
        var typesArray: [String] = []
        for each in pokemon.types {
            typesArray.append(each.type.name.capitalized)
        }
        
        var abilitiesArray: [String] = []
        for each in pokemon.abilities {
            abilitiesArray.append(each.ability.name.capitalized)
        }
        
        self.navigationItem.title = pokemon.name.capitalized
        nameLabel.text = pokemon.name.capitalized
        IDLabel.text = "ID: \(pokemon.id)"
        typesLabel.text = "Types: \(typesArray)"
        abilitiesLabel.text = "Abilites: \(abilitiesArray)"
        
        guard let url = URL(string: pokemon.sprites.frontDefault),
        let imageData = try? Data(contentsOf: url) else { return }
        
        pokemonImage.image = UIImage(data: imageData)
        
        
    }


}

