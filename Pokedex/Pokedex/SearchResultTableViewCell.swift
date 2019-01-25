//
//  SearchResultTableViewCell.swift
//  Pokedex
//
//  Created by Nathanael Youngren on 1/25/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    func updateViews() {
        guard let result = result else { return }
        nameLabel.text = result.name
        idLabel.text = result.id
    }
    
    @IBAction func savePokemonButtonTapped(_ sender: UIButton) {
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    
    var result: Pokemon? {
        didSet {
            updateViews()
        }
    }

}
