//
//  SearchTableViewCell.swift
//  Pokedex
//
//  Created by Ilgar Ilyasov on 9/21/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

protocol SearchTableViewCellDelegate: class {
    func heySaveButtonTapped(on cell: SearchTableViewCell)
}

class SearchTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var cellDelegate: SearchTableViewCellDelegate?
    var pokemon: Pokemon? {
        didSet { updateViews() }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        cellDelegate?.heySaveButtonTapped(on: self)
    }
    
    // MARK: - Update views
    
    private func updateViews() {
        
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
//            typeLabel.text =
//            abilityLabel.text =
        } else {
            nameLabel.text = ""
            idLabel.text = ""
            typeLabel.text = ""
            abilityLabel.text = ""
            saveButtonOutlet.isHidden = true
        }
    }
    
}
