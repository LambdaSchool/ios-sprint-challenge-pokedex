//
//  PokemonDetailViewController.swift
//  Pokadex
//
//  Created by brian vilchez on 9/6/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
	
	//MARK: - outlets
	@IBOutlet weak var pokemonNameLabel: UILabel!
	@IBOutlet weak var pokemonImage: UIImageView!
	@IBOutlet weak var pokimonIDLabel: UILabel!
	@IBOutlet weak var pokemonTypeLabel: UILabel!
	@IBOutlet weak var pokemonAbilityLabel: UILabel!
	
	//MARK: - properties
	var pokemon: Pokemon? {
		didSet {
			updateViews()
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
	//MARK: - methods
	func updateViews() {
		guard let pokemon = pokemon else {return}
		pokemonNameLabel.text = pokemon.name
		pokimonIDLabel.text = String(pokemon.abilities.id)
		pokemonAbilityLabel.text = pokemon.abilities.ability.name
	}
	
}
