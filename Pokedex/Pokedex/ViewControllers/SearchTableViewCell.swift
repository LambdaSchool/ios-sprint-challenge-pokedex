//
//  SearchTableViewCell.swift
//  Pokedex
//
//  Created by Benjamin Hakes on 12/7/18.
//  Copyright © 2018 Benjamin Hakes. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let reuseIdentifier = "searchResultCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func save(_ sender: Any) {
//        guard let pokemon = pokemon else { return }
//        guard let name = nameField.text, !name.isEmpty else { return }
//
//        person.name = name
//        person.cohort = cohortField.text ?? ""
//
//        Model.shared.updatePerson(for: person, completion: {})
        
        navigationController?.popViewController(animated: true)
    }

}
