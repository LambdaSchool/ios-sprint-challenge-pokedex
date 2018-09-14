//
//  SavedPokémonTableViewCell.swift
//  Pokédex
//
//  Created by Jason Modisett on 9/14/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import UIKit

class SavedPokémonTableViewCell: UITableViewCell {

    private func updateViews() {
        guard let pokémon = pokémon else { return }
    }
    
    // MARK:- Properties & types
    var pokémon: Pokémon? { didSet { updateViews() }}
    
    // MARK:- IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var spriteImageView: UIImageView!
    
}
