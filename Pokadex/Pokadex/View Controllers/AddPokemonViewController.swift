//
//  AddPokemonViewController.swift
//  Pokadex
//
//  Created by brian vilchez on 9/6/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import UIKit


class AddPokemonViewController: UIViewController {
	
	//MARK: - properties
	
	var pokemonController: PokemonAPIController?
	var pokemon: Pokemon? {
		didSet {
			updateViews()
		}
	}
	
	//MARK: - outlets
	@IBOutlet weak var pokemonNameLabel: UILabel!
	@IBOutlet weak var pokemonImage: UIImageView!
	@IBOutlet weak var idLabel: UILabel!
	@IBOutlet weak var abilitiesLabel: UILabel!
	@IBOutlet weak var typesLabel: UILabel!
	@IBOutlet weak var searchBar: UISearchBar!
	
	//MARK: - Methods
	
	
	func updateViews() {
		guard isViewLoaded else {return}
		guard let pokemen = pokemon else { return }
		guard let pokemonImageData = try? Data(contentsOf: pokemen.sprites.frontDefault) else {return}
		pokemonImage.image = UIImage(data: pokemonImageData)
		pokemonNameLabel.text = pokemen.name
		idLabel.text = String(pokemen.id)
	
	}
	
	
	
	@IBAction func savePokemonButton(_ sender: UIButton) {
		guard let pokemon = pokemon else {return}
		pokemonController?.savePokemon(with: pokemon)
		navigationController?.popViewController(animated: true)
	}
	
}

extension AddPokemonViewController: UISearchBarDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		searchBar.delegate = self
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let pokemonName = searchBar.text, !pokemonName.isEmpty else { return }
		pokemonController?.searchForPokemon(with: pokemonName.lowercased()) { (pokemon) in
			guard let seearchedPokemon = try? pokemon.get() else {return}
			DispatchQueue.main.async {
				self.pokemon = seearchedPokemon
			}
		}
	
	}
}
