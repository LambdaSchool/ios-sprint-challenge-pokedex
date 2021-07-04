//
//  PokemonSearchTableViewCell.swift
//  Pokedex
//
//  Created by Madison Waters on 9/21/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class PokemonSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
