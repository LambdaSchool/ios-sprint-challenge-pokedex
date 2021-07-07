import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemon: Pokemon?
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let pokemon = pokemon else {return}
        
        title = pokemon.name
        pokemonNameLabel.text = pokemon.name
        pokemonIDLabel.text = "#\(pokemon.id)"
        pokemonTypeLabel.text = "\(pokemon.types)"
        pokemonAbilitiesLabel.text = "\(pokemon.abilities)"
        
    }

}
