//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Taylor Lyles on 5/17/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
	var pokemonController: PokemonController?
	var pokemon: Pokemon?
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var idLabel: UILabel!
	@IBOutlet weak var typeslabel: UILabel!
	@IBOutlet weak var abilitieslabel: UILabel!
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		searchBar.delegate = self
		
		if let selectedPokemon = pokemon {
			guard let pokeController = pokemonController else { return }
			
			updateView(with: selectedPokemon)
			
			pokeController.getImage(at: selectedPokemon.sprites.frontDefault) { result in
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
	
	func searchBarClicked(_ searchBar: UISearchBar) {
		guard let text = searchBar.text?.lowercased() else { return }
		guard let pokeController = pokemonController else { return }
		
		pokeController.search(for: text) { (result) in
			do {
				let thisPokemon = try result.get()
				DispatchQueue.main.async {
					self.updateView(with: thisPokemon)
				}
				pokeController.getImage(at: thisPokemon.sprites.frontDefault, completion: { result in
					do {
						let image = try result.get()
						DispatchQueue.main.async {
							self.imageView.image = image
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
	
	func updateView(with pokemonSearchedFor: Pokemon) {
		nameLabel.text = pokemonSearchedFor.name
		idLabel.text = String(pokemonSearchedFor.id)
		typeslabel.text = pokemonSearchedFor.types[0].type.name
		abilitieslabel.text = pokemonSearchedFor.abilities[0].ability.name
	}
	
	@IBAction func saveButton(_ sender: Any) {
		guard let pokeSave = pokemon else { return }
		guard let pokeController = pokemonController else { return }
		pokeController.save(poke: pokeSave)
		
		navigationController?.popViewController(animated: true)
	}
	

}
