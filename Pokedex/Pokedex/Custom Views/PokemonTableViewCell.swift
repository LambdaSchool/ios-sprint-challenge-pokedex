//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Eoin Lavery on 22/07/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
