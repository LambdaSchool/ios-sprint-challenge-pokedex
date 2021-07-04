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
	@IBOutlet weak var toggleLbl: UILabel!
	@IBOutlet weak var idLbl: UILabel!
	@IBOutlet weak var typesLbl: UILabel!
	@IBOutlet weak var abilitiesLbl: UILabel!
	@IBOutlet weak var saveBtn: UIButton!
	
	//MARK: - Properties
	
	var pokeController: PokeController!
	var pokemonToDisplay: Pokemon?
	private var spriteView = SpriteView.regular
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		searchBar.delegate = self
		hideViews(true)
		saveBtn.isHidden = true
		
		if let pokemon = pokemonToDisplay {
			title = pokemon.name
			searchBar.isHidden = true
			updateViews()
		}
	}
	
	//MARK: - IBActions
	
	@IBAction func saveBtnTapped(_ sender: Any) {
		guard let pokemon = pokemonToDisplay else { return }
		pokeController.add(pokemon: pokemon)
		saveBtn.isEnabled = false
	}
	
	@IBAction func spriteTapGesture(_ sender: Any) {
		guard let sprites = pokemonToDisplay?.sprites else { return }
		
		switch spriteView {
		case .regular:
			spriteImgView.load(url: sprites.frontShiny)
			spriteView = .shiny
		case .shiny:
			spriteImgView.load(url: sprites.frontDefault)
			spriteView = .regular
		}
	}
	//MARK: - Helpers
	
	private func hideViews(_ verdict: Bool) {
		spriteImgView.isHidden = verdict
		toggleLbl.isHidden = verdict
		idLbl.isHidden = verdict
		typesLbl.isHidden = verdict
		abilitiesLbl.isHidden = verdict
	}
	
	private func updateViews() {
		guard let pokemon = pokemonToDisplay else { return }
		
		title = pokemon.name.capitalized
		idLbl.text = "ID: \(pokemon.id)"
		typesLbl.text = "Types: \(pokemon.types.map{$0.type.name.capitalized}.joined(separator: ", "))"
		abilitiesLbl.text = "Abilities: \(pokemon.abilities.map{$0.ability.name.capitalized}.joined(separator: ", "))"
		spriteImgView.load(url: pokemon.sprites.frontDefault)
		
		hideViews(false)
		spriteView = .regular
	}
	
	private func performSearch(for searchTerm: String) {
		pokeController.getPokemon(by: searchTerm) { (result) in
			guard let result = try? result.get() else { return }
			DispatchQueue.main.async {
				self.pokemonToDisplay = result
				self.updateViews()
				self.saveBtn.isEnabled = true
				self.saveBtn.isHidden = false
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

extension UIImageView {
	func load(url: URL) {
		DispatchQueue.global().async { [weak self] in
			if let data = try? Data(contentsOf: url) {
				if let image = UIImage(data: data) {
					DispatchQueue.main.async {
						self?.image = image
					}
				}
			}
		}
	}
}
