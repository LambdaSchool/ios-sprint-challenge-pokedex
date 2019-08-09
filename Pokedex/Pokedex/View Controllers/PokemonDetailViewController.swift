//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Taylor Lyles on 8/9/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
	
	var pokemonController: PokemonController?
	var pokemon: Pokemon?
	
	@IBOutlet weak var pokemonSearchBar: UISearchBar!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var pokemonImageView: UIImageView!
	@IBOutlet weak var pokemonIdLabel: UILabel!
	@IBOutlet weak var pokemonTypeLabel: UILabel!
	@IBOutlet weak var pokemonAbilitiesLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	func searchClicked(_ searchBar: UISearchBar) {
		guard let text = pokemonSearchBar.text?.lowercased() else { return }
		guard let pokeController = pokemonController else { return }
		
		pokemonController?.searchPokemon(for: text) { (result) in
			
			do {
				let thisPokemon = try result.get()
				DispatchQueue.main.async {
					self.updateView(with: thisPokemon)
				}
				
				pokeController.getImage(at: thisPokemon.sprites.fontDefault) { (result) in
					
					do {
						let image = try result.get()
						DispatchQueue.main.async {
							self.pokemonImageView.image = image
						}
					} catch {
						NSLog("Could not load image")
					}
				}
				self.pokemon = thisPokemon
			} catch {
				NSLog("Error: \(error)")
			}
		}
	}
	
	func updateView(with searchedPokemon: Pokemon) {
		nameLabel.text = searchedPokemon.name
		pokemonIdLabel.text = String(searchedPokemon.Id)
		pokemonTypeLabel.text = searchedPokemon.type[0].type
		pokemonAbilitiesLabel.text = searchedPokemon.abilities[0].abilities
	}
	
	@IBAction func savePokemonButton(_ sender: UIButton) {
	}
	
	
	
}
