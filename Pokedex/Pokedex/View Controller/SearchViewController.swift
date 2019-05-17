//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Taylor Lyles on 5/17/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
	
	@IBOutlet weak var searchbar: UISearchBar!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var idLabel: UILabel!
	@IBOutlet weak var typeslabel: UILabel!
	@IBOutlet weak var abilitieslabel: UILabel!
	
	var pokemonController: PokemonController?
	var pokemon: Pokemon?
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		searchbar.delegate = self
		
		if let selectedPokemon = pokemon {
			guard let pokeController = pokemonController else { return }
			
			updateView(with: selectedPokemon)
			
			pokeController.getImage(urlString: selectedPokemon.sprites.sprite) { result in
				do {
					let image = try result.get()
					DispatchQueue.main.async {
						self.imageView.image = image
					}
				} catch {
					print("Could not load image")
				}
			}
		}

        
    }
	
	func searchBarClicked(searchBar: UISearchBar) {
		guard let text = searchbar.text?.lowercased() else { return }
		guard let pokeController = pokemonController else { return }
		
		pokeController.search(for: text) { (result) in
			do {
				let thisPokemon = try result.get()
				DispatchQueue.main.async {
					self.updateView(with: thisPokemon)
				}
				pokeController.getImage(urlString: thisPokemon.sprites.sprite, completion: { result in
					do {
						let image = try result.get()
						DispatchQueue.main.async {
							self.imageView.image = image
						}
					} catch {
						NSLog("Could not load")
					}
				})
				self.pokemon = thisPokemon
			} catch {
				NSLog("error")
			}
		}
	}
	
	func updateView(with pokemnoSearchedFor: Pokemon) {
		nameLabel.text = pokemnoSearchedFor.name
		idLabel.text = String(pokemnoSearchedFor.id)
		typeslabel.text = pokemnoSearchedFor.types[0].type.name
		abilitieslabel.text = pokemnoSearchedFor.abilities[0].ability.name
	}

}
