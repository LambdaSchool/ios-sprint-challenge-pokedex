import UIKit

class PokemonDetailViewController: UIViewController {
    
    var savedPokemon: Pokemon?
    
    // Detail View Controller Outlets
    // Pokemon Name
    @IBOutlet weak var pokemonDetailName: UILabel!
    // Pokemon ID
    @IBOutlet weak var pokemonDetailID: UILabel!
    // Pokemon Type(s)
    @IBOutlet weak var pokemonDetailTypes: UILabel!
    // Pokemon Abilities
    @IBOutlet weak var pokemonDetailAbilities: UILabel!
    // Pokemon Image/Sprite
    @IBOutlet weak var pokemonDetailImageView: UIImageView!
    
    // TODO: Complete or delete
    @IBOutlet weak var detailVCTitle: UINavigationItem!
    
    // Code that might be removed later.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let presentedPokemon = self.savedPokemon else { fatalError("Could not obtain Pokemon.")}
        
        detailVCTitle.title = presentedPokemon.name
        
        pokemonDetailName.text = presentedPokemon.name
        
        pokemonDetailID.text = "ID: \(presentedPokemon.id)"
        
        pokemonDetailTypes.text = "Types: "
        
        pokemonDetailAbilities.text = "Abilities: "
        
        // Unwrap the URL if a valid, non-empty sprite is returned
        guard let urlString = presentedPokemon.sprites?.frontDefault else { return }
        // Set the link to the image
        guard let imageURL = URL(string: urlString), let imageData = try? Data(contentsOf: imageURL) else { fatalError("Couldn't obtain image.")}
        // Set the ImageView to the imageData in the form of a usable UIImage
        self.pokemonDetailImageView?.image = UIImage(data: imageData)
    }

}
