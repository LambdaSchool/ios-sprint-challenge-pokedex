import UIKit

class DetailTableViewController: UIViewController {
    
    @IBOutlet weak var pokeNameDetailTopLabel: UILabel!
    
    @IBOutlet weak var pokeNameDetailLabel: UILabel!
    
    @IBOutlet weak var pokeIdDetailLabel: UILabel!
    
    @IBOutlet weak var pokeTypesDetailLabel: UILabel!
    
    @IBOutlet weak var pokeAbilitiesDetailLabel: UILabel!
    
    @IBOutlet weak var pokeImageDetailView: UIImageView!
    
    var pokemon: Pokemon?
    
    // Called just before detail view controller appears on-screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Ensure we have a pokemon to present
        guard let pokemon = pokemon else { return }
        
        // Populate the labels
        pokeNameDetailTopLabel.text = pokemon.name
        pokeNameDetailLabel.text = pokemon.name
        pokeIdDetailLabel.text = String(pokemon.id)
        pokeTypesDetailLabel.text = String(pokemon.types)
        pokeAbilitiesDetailLabel.text = String((pokemon.abilities)
        pokeImageDetailView.image = UIImage(named: "\(pokemon.sprites)")
    }
    
}
