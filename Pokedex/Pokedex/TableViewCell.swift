//
//  TableViewCell.swift
//  Pokedex
//
//  Created by Ivan Caldwell on 12/7/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let reuseIdentifier = "cell"
    @IBOutlet var tableViewCellNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
