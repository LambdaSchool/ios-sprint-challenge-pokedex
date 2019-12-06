//
//  PokedexTableViewCell.swift
//  SprintChallengePokedex
//
//  Created by Chad Rutherford on 12/6/19.
//  Copyright © 2019 lambdaschool.com. All rights reserved.
//

import UIKit

class PokedexTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    var pokemon: Pokemon? {
        didSet {
            configureCell()
        }
    }
    
    private func configureCell() {
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
    }
}
