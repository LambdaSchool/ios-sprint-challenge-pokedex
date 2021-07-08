import UIKit

class PokemonCell: UITableViewCell {
    
    @IBOutlet weak var contentImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
