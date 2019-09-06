//
//  AddPokemonViewController.swift
//  Pokadex
//
//  Created by brian vilchez on 9/6/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import UIKit
protocol AddPokemonDelegate {
	func addPokemon()
}

class AddPokemonViewController: UIViewController {
	
	//MARK: - properties
	var delegate: AddPokemonDelegate?
	
	//MARK: - outlets
	@IBOutlet weak var pokemonNameLabel: UILabel!
	@IBOutlet weak var pokemonImage: UIImageView!
	@IBOutlet weak var idLabel: UILabel!
	@IBOutlet weak var abilitiesLabel: UILabel!
	@IBOutlet weak var typesLabel: UILabel!
	@IBOutlet weak var searchBar: UISearchBar!
	
	//MARK: - Methods
	@IBAction func savePokemonButton(_ sender: UIButton) {
		
	}
	
}

extension AddPokemonViewController: UISearchBarDelegate {
	
	
}
