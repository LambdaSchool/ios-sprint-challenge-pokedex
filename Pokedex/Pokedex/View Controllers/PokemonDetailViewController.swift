//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Taylor Lyles on 8/9/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
	
	@IBOutlet weak var pokemonSearchBar: UISearchBar!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var pokemonImageView: UIImageView!
	@IBOutlet weak var pokemonIdLabel: UILabel!
	@IBOutlet weak var pokemonTypeLabel: UILabel!
	@IBOutlet weak var pokemonAbilitiesLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	@IBAction func savePokemonButton(_ sender: UIButton) {
	}
	
}
