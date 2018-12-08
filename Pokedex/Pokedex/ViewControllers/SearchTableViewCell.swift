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
    var onComplete: (() -> Void)? = nil
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func save(_ sender: Any) {
        
        let pokemon = Model.shared.results[0]
        
        Model.shared.deleteResults()
        
        Model.shared.addNewPokemon(pokemon: pokemon){
            
            self.onComplete?()
        }
        
    }
    

}
