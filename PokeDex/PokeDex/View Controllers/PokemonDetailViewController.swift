import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemon: Pokemon?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameLabel.text = pokemon?.name
        idLabel.text = pokemon?.id
//        typeLabel.text = pokemon?.types.joined(separator: ", ")
//        abilitiesLabel.text = pokemon?.abilities.joined(separator: ", ")
    }
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBAction func save(_ sender: Any) {
        Model.shared.savePokemon(pokemon: pokemon!)
    }
    
    
    
}
