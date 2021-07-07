//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Nikita Thomas on 10/26/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    
    weak var delegate: SavedPokemonCellDelegate?
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func saveButtonPressed(_ sender: Any) {
        delegate?.saveButtonTapped(cell: self)
    }
    @IBOutlet weak var saveButtonName: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}

protocol SavedPokemonCellDelegate: AnyObject {
    func saveButtonTapped(cell: PokemonTableViewCell)
}
