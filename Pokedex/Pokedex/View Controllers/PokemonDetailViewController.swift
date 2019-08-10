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
		
		pokemonSearchBar.delegate = self
		
		if let selectedPoke = pokemon {
			guard let pokeController = pokemonController else { return }
			
			updateView(with: selectedPoke)
			
			pokeController.getImage(at: selectedPoke.sprites.frontDefault) { (result) in
				do {
					let image = try result.get()
					DispatchQueue.main.async {
						self.pokemonImageView.image = image
					}
				} catch {
					NSLog("Could not load image")
				}
			}
		}
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let text = searchBar.text?.lowercased() else { return }
		guard let pokeController = pokemonController else { return }
		
		pokeController.searchPokemon(for: text) { (result) in
			do {
				let thisPokemon = try result.get()
				DispatchQueue.main.async {
					self.updateView(with: thisPokemon)
				}
				pokeController.getImage(at: thisPokemon.sprites.frontDefault, completion: { result in
					do {
						let image = try result.get()
						DispatchQueue.main.async {
							self.pokemonImageView.image = image
						}
					} catch {
						print("Could not load")
					}
				})
				self.pokemon = thisPokemon
			}
			catch {
				print("error")
			}
		}
	}
	
	func updateView(with searchedPokemon: Pokemon) {
		nameLabel.text = searchedPokemon.name
		pokemonIdLabel.text = String(searchedPokemon.id)
		pokemonTypeLabel.text = searchedPokemon.types[0].type.name
		pokemonAbilitiesLabel.text = searchedPokemon.abilities[0].ability.name
	}
	
	@IBAction func savePokemonButton(_ sender: UIButton) {
		guard let pokemonSaved = pokemon else { return }
		guard let pokeController = pokemonController else { return }
		pokeController.save(poke: pokemonSaved)
		navigationController?.popViewController(animated: true)
	}
}

extension PokemonDetailViewController: UISearchBarDelegate {
	
}
