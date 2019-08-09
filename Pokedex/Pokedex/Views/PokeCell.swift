//
//  PokeCell.swift
//  Pokedex
//
//  Created by Jeffrey Santana on 8/9/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class PokeCell: UITableViewCell {

	@IBOutlet weak var nameLbl: UILabel!
	@IBOutlet weak var spriteImgView: UIImageView!
	
	var pokemon: Pokemon? {
		didSet {
			configCell()
		}
	}
	
	private func configCell() {
		guard let pokemon = pokemon else { return }
		
		nameLbl.text = pokemon.name.capitalized
		spriteImgView.load(url: pokemon.sprites.frontDefault)
	}

}
