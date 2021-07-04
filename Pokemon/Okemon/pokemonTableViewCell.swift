//
//  pokemonTableViewCell.swift
//  Okemon
//
//  Created by Jonathan Ferrer on 5/17/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import UIKit

class pokemonTableViewCell: UITableViewCell {

    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    @IBOutlet weak var nameTextLabel: UILabel!

    @IBOutlet weak var pokemonImageView: UIImageView!

     func updateViews() {

        guard let imageData = pokemon!.imageData else { return }
        guard let pokemon = pokemon else { return }

        nameTextLabel.text = pokemon.name
        pokemonImageView.image = UIImage(data: imageData)
    }

}
