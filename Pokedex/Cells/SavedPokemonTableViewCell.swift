//
//  SavedPokémonTableViewCell.swift
//  Pokédex
//
//  Created by Jason Modisett on 9/14/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import UIKit

class SavedPokemonTableViewCell: UITableViewCell {

    // MARK:- View update method
    private func updateViews() {
        guard let pokémon = pokémon else { return }
        
        nameLabel.text = pokémon.name.capitalizingFirstLetter()
        idLabel.text = "ID: \(pokémon.id)"
    }
    
    // MARK:- Properties & types
    var pokémon: Pokémon? { didSet { updateViews() }}
    
    // MARK:- IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var spriteImageView: UIImageView!
    
}
