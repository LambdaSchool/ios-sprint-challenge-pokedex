import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var Pokemon: Pokemon!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon:Pokemon) {
        self.Pokemon = pokemon
        nameLbl.text = self.Pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.Pokemon.pokemonId)")
        
    }
    
}
