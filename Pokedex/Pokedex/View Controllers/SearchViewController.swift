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
	@IBOutlet weak var abilitiesLabel: UILabel!
	@IBOutlet weak var saveButton: UIButton!


	var apiController: APIController!
	var searchPokemon: String?

    override func viewDidLoad() {
        super.viewDidLoad()

		searchBar.delegate = self
		hideViews(true)

		if let searchedPokemon = searchPokemon {
			title = searchedPokemon

		}
    }
    
	private func updateViews(with pokemon: Pokemon) {
		title = pokemon.name.capitalized
		idLabel.text = "ID: \(pokemon.id)"
		typeLabel.text = "Types: \(pokemon.types.map{$0.type.name.capitalized}.joined(separator: ", "))"

		hideViews(false)
		saveButton.isHidden = searchPokemon == nil ? false : true
	}


	private func performSearch(for searchTerm: String) {
		apiController.getPokemons(by: searchTerm) { ( result ) in
			guard let result = try? result.get() else { return }
			DispatchQueue.main.async {
				self.updateViews(with: result)
			}
		}
	}

	private func hideViews(_ verdict: Bool) {
		imageView.isHidden = verdict
		idLabel.isHidden = verdict
		typeLabel.isHidden = verdict
		abilitiesLabel.isHidden = verdict
	}



	@IBAction func saveButtonTapped(_ sender: Any) {
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


