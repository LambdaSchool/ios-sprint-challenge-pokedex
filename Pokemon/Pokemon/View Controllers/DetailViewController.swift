import UIKit

class DetailViewController: UIViewController {

    
    // MARK: - Properties
    
    var delegate: PokeDexTableViewController?
    var pokemonController: PokemonController?
    var pokemonSent: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonTypes: UILabel!
    @IBOutlet weak var pokemonAbilities: UILabel!
    @IBOutlet weak var buttonTextLabel: UIButton!
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    func updateViews() {
        guard let pokemon = pokemonSent else {
            print("No Pokemon Set")
            return
        }
        print("Have this pokemon: \(pokemon.name)")
        DispatchQueue.main.async {
            self.pokemonName.text = pokemon.name
            self.pokemonID.text = "ID: " + String(pokemon.id)
            self.buttonTextLabel.isEnabled = true
            self.pokemonController?.fetchImage(at: pokemon.sprites.front_default, completion: { (result) in
                print("Starting")
                guard let image = result else { return }
                DispatchQueue.main.async {
                    self.pokemonImage.image = image
                }
            })
            self.pokemonTypes.text = "Types: " + pokemon.types.map { $0.type.name }.joined(separator: ", ")
            self.pokemonAbilities.text = "Abilities: " + pokemon.abilities.map { $0.ability.name }.joined(separator: ", ")
        }
    }
    // MARK: - IBActions
    @IBAction func deleteTapped(_ sender: UIButton) {
        guard let pokemonController = pokemonController,
            let pokemon = pokemonSent else { return }
        guard let indexToRemove = pokemonController.savedPokemon.firstIndex(where: { $0.name == pokemon.name }) else { return print("No item to remove")}
        pokemonController.savedPokemon.remove(at: indexToRemove)
        delegate?.tableView.reloadData()
        _ = navigationController?.popToRootViewController(animated: true)
    }
}
