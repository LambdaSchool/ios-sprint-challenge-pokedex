//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Percy Ngan on 9/6/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var idLabel: UILabel!
	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var abilitiyLabel: UILabel!
	@IBOutlet weak var saveButton: UIButton!


	
	var apiController: APIController?
	var searchPokemon: String?
	

	override func viewDidLoad() {
		super.viewDidLoad()

		searchBar.delegate = self
		hideViews(true)
		saveButton.isHidden = true

		if let searchedPokemon = searchPokemon {
			title = searchedPokemon
			searchBar.isHidden = true
			performSearch(for: searchedPokemon)
		}
	}

	private func updateViews(with pokemon: Pokemon) {
		title = pokemon.name.capitalized
		nameLabel.text = "\(pokemon.name.capitalized)"
		idLabel.text = "ID: \(pokemon.id)"
		typeLabel.text = "Types: \(pokemon.types.map{$0.type.name.capitalized}.joined(separator: ", "))"
		abilitiyLabel.text = "Abilities: \(pokemon.abilities.map{$0.ability.name.capitalized}.joined(separator: ", "))"
		imageView.load(url: pokemon.sprites.frontDefault)

		hideViews(false)
		saveButton.isHidden = searchPokemon == nil ? false : true
	}


	private func performSearch(for searchedPokemon: String) {
		apiController?.getPokemons(by: searchedPokemon) { ( result ) in
			guard let result = try? result.get() else { return }
			print(result)
			DispatchQueue.main.async {
				self.updateViews(with: result)
			}
		}
	}

	private func hideViews(_ verdict: Bool) {
		imageView.isHidden = verdict
		idLabel.isHidden = verdict
		typeLabel.isHidden = verdict
		abilitiyLabel.isHidden = verdict
	}


	// MARK: - IBActions

	@IBAction func saveButtonTapped(_ sender: Any) {
		guard let name = title else { return }
		apiController?.addPokemon(pokemon: name)
		saveButton.isEnabled = false
		self.navigationController?.popViewController(animated: true)
	}


}

extension SearchViewController: UISearchBarDelegate {
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
