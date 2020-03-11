//
//  PokeCellTableViewCell.swift
//  Pokedex
//
//  Created by Joel Groomer on 9/14/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import UIKit

class PokeCellTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPokemonId: UILabel!
    @IBOutlet weak var lblPokemonName: UILabel!

    var pokemon: Pokemon? { didSet { updateViews() } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        lblPokemonId.text = "#\(pokemon.id)"
        lblPokemonName.text = pokemon.name
    }

}
