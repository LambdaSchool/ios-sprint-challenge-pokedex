//
//  PokedexTableViewCell.swift
//  SprintChallengePokedex
//
//  Created by Chad Rutherford on 12/6/19.
//  Copyright © 2019 lambdaschool.com. All rights reserved.
//

import UIKit

class PokedexTableViewCell: UITableViewCell {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    var pokemon: Pokemon? {
        didSet {
            configureCell()
        }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Cell Configuration
    /// Function to configure the TableView Cell
    private func configureCell() {
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
    }
}
