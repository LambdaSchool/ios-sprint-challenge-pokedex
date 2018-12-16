

import UIKit

class SearchedPokemonsCell: UITableViewCell {
    
    static let reuseIdentifier = "searchedcell"
    
    @IBOutlet weak var searchedPokeNameLabel: UILabel!
    
    @IBOutlet weak var searchedPokeIDLabel: UILabel!
    
    @IBOutlet weak var searchedPokeTypesLabel: UILabel!
    
    @IBOutlet weak var searchedPokeAbilitiesLabel: UILabel!
    
    @IBOutlet weak var searchedPokeSpriteView: UIImageView!
    /*
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        // Check to make sure there is a pokemon
        guard let pokemon = pokemon else { return }
        
        // Set all the things
        searchedPokeNameLabel.text = pokemon.name
        searchedPokeIDLabel.text = "ID: \(pokemon.id)"
        searchedPokeTypesLabel.text = "Types: \(pokemon.types)"
        searchedPokeAbilitiesLabel.text = "Abilities: \(pokemon.abilities)"
        
        // Get a url, try to load image data from that URL
        guard let url = URL(string: pokemon.sprites.frontDefault), let imageData = try? Data(contentsOf: url) else { return }
        
        searchedPokeSpriteView?.image = UIImage(data: imageData)
    }
    */
}
