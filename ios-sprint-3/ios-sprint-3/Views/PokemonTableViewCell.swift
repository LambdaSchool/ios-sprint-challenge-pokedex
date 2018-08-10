//
//  PokemonTableViewCell.swift
//  ios-sprint-3
//
//  Created by Lambda-School-Loaner-11 on 8/10/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
   
    @IBOutlet weak var nameLabel: UILabel!
    
    func updateViews() {
        
        guard let pokemon = pokemon else { return }
        
        self.nameLabel.text = pokemon.name
    }
}
