//
//  PokeDetailViewController.swift
//  Pokedex
//
//  Created by Hector Steven on 5/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class PokeDetailViewController: UIViewController, UISearchBarDelegate {

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		searchBar.delegate = self

    }
    
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let text = searchBar.text else { return }
		
		pokeController?.fetchPokemonData(text, completion: { error in
			if let error = error {
				print("error fetching \(error)")
				return
			} else {
				
				DispatchQueue.main.async {
					self.pokemon = self.pokeController?.currentPokemon
					
				}
			}
		})
	}
	
	func setupViews () {
		guard let pokemon = pokemon else { return }
		pokeLabel?.text = pokemon.name
		pokeidLabel?.text = String(pokemon.id)
	}
	
	
	@IBOutlet var pokeLabel: UILabel!
	@IBOutlet var pokeidLabel: UILabel!
	@IBOutlet var pokeAbilitiesLabel: UILabel!
	@IBOutlet var pokeImageView: UIImageView!
	@IBOutlet var searchBar: UISearchBar!
	
	
	var pokeController: PokeController? { didSet {print("Controller passed")}}
	var pokemon: Pokemon? {
		didSet {
			setupViews()
		}
	}
}
