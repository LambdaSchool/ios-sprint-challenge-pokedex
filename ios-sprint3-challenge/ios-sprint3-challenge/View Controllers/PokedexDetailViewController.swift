import Foundation
import UIKit

class PokedexDetailViewController: UIViewController {
    var savedPoke: Pokemon?
    
    override func viewDidLoad() {
        super .viewDidLoad()
        pokedexDetailTitleLabel.text = savedPoke?.name
        pokemonNameLabel.text = savedPoke?.name
        pokemonIdLabel.text = "ID: \(savedPoke!.id!)"
        pokemonTypesLabel.text = "Types: \(savedPoke!.types![0].type!.name!)"
        pokemonAbilitiesLabel.text = "Abilities: \(savedPoke!.abilities![0].ability!.name!)"
        pokemonSpriteImageView.loadImageFrom(url: URL(string: savedPoke!.sprites?.frontDefault ?? "https://via.placeholder.com/128x201?text=Cover%20Image%20Unavailable")!)
    }
    
    @IBOutlet weak var pokedexDetailTitleLabel: UILabel!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    @IBOutlet weak var pokemonIdLabel: UILabel!
    
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    
    
}
