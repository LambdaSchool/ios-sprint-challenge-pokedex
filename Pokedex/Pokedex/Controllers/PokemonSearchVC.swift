//
//  PokemonSearchVC.swift
//  Pokedex
//
//  Created by Jeffrey Santana on 8/9/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class PokemonSearchVC: UIViewController {
	
	//MARK: - IBOutlets
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var spriteImgView: UIImageView!
	@IBOutlet weak var idLbl: UILabel!
	@IBOutlet weak var typesLbl: UILabel!
	@IBOutlet weak var abilitiesLbl: UILabel!
	@IBOutlet weak var saveBtn: UIButton!
	
	//MARK: - Properties
	
	var pokeController: PokeController!
	var pokemonToSearch: String?
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		searchBar.delegate = self
		hideViews(true)
		
		if let searchTerm = pokemonToSearch {
			title = searchTerm
			performSearch(for: searchTerm)
		}
	}
	
	//MARK: - IBActions
	
	@IBAction func saveBtnTapped(_ sender: Any) {
	}
	
	//MARK: - Helpers
	
	private func hideViews(_ verdict: Bool) {
		spriteImgView.isHidden = verdict
		idLbl.isHidden = verdict
		typesLbl.isHidden = verdict
		abilitiesLbl.isHidden = verdict
	}
	
	private func updateViews(with pokemon: Pokemon) {
		title = pokemon.name.capitalized
		idLbl.text = "ID: \(pokemon.id)"
		typesLbl.text = "Types: \(pokemon.types.map{$0.type.name.capitalized}.joined(separator: ", "))"
		abilitiesLbl.text = "Abilities: \(pokemon.abilities.map{$0.ability.name.capitalized}.joined(separator: ", "))"
		
		hideViews(false)
		saveBtn.isHidden = pokemonToSearch == nil ? false : true
	}
	
	private func performSearch(for searchTerm: String) {
		pokeController.getPokemon(by: searchTerm) { (result) in
			guard let result = try? result.get() else { return }
			DispatchQueue.main.async {
				self.updateViews(with: result)
			}
		}
	}
}

extension PokemonSearchVC: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchTerm = searchBar.optionalText else { return }
		performSearch(for: searchTerm)
	}
}

extension UISearchBar {
	var optionalText: String? {
		let trimmedText = self.text?.trimmingCharacters(in: .whitespacesAndNewlines)
		return (trimmedText ?? "").isEmpty ? nil : trimmedText
	}
}
