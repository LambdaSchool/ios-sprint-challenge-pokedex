import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemonController: PokemonController?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateViews() {
        guard let pokemon = pokemon else {return}
        
        title = pokemon.name
        
        let abilities = pokemon.abilities.map {$0.ability.name}.joined(separator: ",")
        let type = pokemon.types.map {$0.type.name}.joined(separator: ",")
        
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        typeLabel.text = "Types: \(type)"
        abilitiesLabel.text = "Abilities: \(abilities)"
    }
    
    
//    var detailtempPoke: tempPoke? {
//        didSet {
//            configureView()
//        }
//    }
    
//    func configureView() {
//        if let detailtempPoke = detailtempPoke {
//            if let nameLabel = nameLabel {
//                nameLabel.text = detailtempPoke.name
//                //tempPokeImageView.image = UIImage(named: detailtempPoke.name)
//                title = detailtempPoke.category
//            }
//        }
//    }
    
}
