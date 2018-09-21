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
    var pokemon: Pokemon?
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        cellDelegate?.heySaveButtonTapped(on: self)
    }
    
}
