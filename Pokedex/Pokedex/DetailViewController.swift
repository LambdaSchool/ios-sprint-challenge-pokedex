import UIKit

class DetailViewController: UIViewController, UISearchBarDelegate {
    var character: Character?
    
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func save(_ sender: Any) {
        guard let character = character else { return }
        guard let name = characterLabel.text, !name.isEmpty else { return }
        Model.shared.add(character: character)
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var spriteView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            let character = Model.shared.character(at: IndexPath)
            self.characterLabel.text = character.name
            self.idLabel.text = "ID: \(character.id)"
            self.typeLabel.text = "Types: \(character.type)"
            self.abilityLabel.text = "Abilities: \(character.ability)"
            self.spriteView.image = character.sprite
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty
            else { return }
    }
    
}

