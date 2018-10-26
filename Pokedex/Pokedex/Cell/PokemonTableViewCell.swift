import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
//    @IBOutlet weak var nameLabel: UILabel!
    // add sprite outlet
    
    func updateViews() {
//        guard let pokemon = pokemon else { return }
//        nameLabel.text = pokemon.name
        
        // get level
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
