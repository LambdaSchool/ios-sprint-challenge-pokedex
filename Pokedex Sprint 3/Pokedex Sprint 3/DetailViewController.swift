import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var IDLabel: UILabel!
    @IBOutlet var abilityLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    
    @IBAction var saveButton: UIButton {
        guard let pokemon = pokemon else { return }
    }
    
    var pokemon: Pokemon?
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let pokemon = pokemon else { return }
            
        nameLabel.text = pokemon.name
        IDLabel.text = pokemon.ID
        abilityLabel.text = pokemon.ability
        typeLabel.text = pokemon.types
    }
        
    
}

