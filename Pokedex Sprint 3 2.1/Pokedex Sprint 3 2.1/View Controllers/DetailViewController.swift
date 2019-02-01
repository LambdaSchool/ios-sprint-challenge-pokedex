import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var viewController = SearchViewController()
    var pokemon: Pokemon?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let pokemon = pokemon else { return }
        
        var typesArray: [String] = []
        for each in pokemon.types {
            typesArray.append(each.type.name.capitalized)
        }
        
        var abilitiesArray: [String] = []
        for each in pokemon.abilites {
            abilitiesArray.append(each.ability.name.capitalized)
        }
        
        self.navigationItem.title = pokemon.name.capitalized
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        typesLabel.text = "Types: \(typesArray)"
        abilitiesLabel.text = "Abilites: \(abilitiesArray)"
        
        guard let url = URL(string: pokemon.sprites.frontDefault),
            let imageData = try? Data(contentsOf: url) else { return }
        
        imagePokemon.image = UIImage(data: imageData)
        
        
    }
    
    
}

