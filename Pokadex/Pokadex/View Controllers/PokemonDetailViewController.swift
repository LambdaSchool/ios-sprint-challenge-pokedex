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
    var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
		updateViews()
    }
    
	//MARK: - methods
	func updateViews() {
		guard isViewLoaded else {return}
		guard let pokemon = pokemon else {return}
		guard let imageData = try? Data(contentsOf: pokemon.sprites.frontDefault) else {return}
		pokemonNameLabel.text = pokemon.name
		pokemonImage.image = UIImage(data: imageData)
        pokimonIDLabel.text = "ID: \(pokemon.id)"
        for type in pokemon.types {
            pokemonTypeLabel.text = "Type: \(type.type.name)"
        }
        for ability in pokemon.abilities {
            pokemonAbilityLabel.text = "Ability: \(ability.ability.name)"
        }
		
	}
	
}
