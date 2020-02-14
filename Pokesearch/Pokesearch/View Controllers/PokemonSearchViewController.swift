//
//  PokemonSearchViewController.swift
//  Pokesearch
//
//  Created by Michael Redig on 5/10/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
	@IBOutlet var pokemonSearchBar: UISearchBar!

	@IBOutlet var pokemonNameLabel: UILabel!
	@IBOutlet var pokemonIDLabel: UILabel!
	@IBOutlet var primaryStackView: UIStackView!
	@IBOutlet var typeLabel: UILabel!
	@IBOutlet var abilitiesLabel: UILabel!
	@IBOutlet var throwPokeballButton: UIButton!

	@IBOutlet var spriteCollectionView: UICollectionView!

	var alreadyCaught = false

	var pokemonController: PokemonController?
	var pokemon: Pokemon? {
		didSet {
			updateViews()
		}
	}
	private var spritesURLs: [String]?

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		showViews(show: false, hideButton: alreadyCaught)
		updateViews()

		pokemonSearchBar.delegate = self
	}

	func updateViews() {
		guard let pokemon = pokemon, isViewLoaded else { return }
		showViews(show: true, hideButton: alreadyCaught)
		pokemonNameLabel.text = pokemon.name.capitalized
		pokemonIDLabel.text = "\(pokemon.id)"
		typeLabel.text = pokemon.types.reduce ([String]()) { $0 + [$1.type.name]}.joined(separator: ", ")
		abilitiesLabel.text = pokemon.abilities.reduce([String]()) { $0 + [$1.ability.name]}.joined(separator: ", ")
		spritesURLs = pokemon.sprites.compactMap { $0.value }.sorted()
		spriteCollectionView.reloadData()
	}

	func showViews(show: Bool, hideButton: Bool = false) {
		primaryStackView.isHidden = !show
		pokemonNameLabel.isHidden = !show
		pokemonIDLabel.isHidden = !show
		throwPokeballButton.isEnabled = show
		throwPokeballButton.isHidden = hideButton
	}

	@IBAction func throwPokeballPressed(_ sender: UIButton) {
		guard let pokemon = pokemon else { return }
		pokemonController?.catchPokemon(pokemon)
		navigationController?.popViewController(animated: true)
	}
}

extension PokemonSearchViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchText = searchBar.text, !searchText.isEmpty else { return }
		searchBar.resignFirstResponder()
		pokemonController?.searchForPokemon(named: searchText, completion: { [weak self] (result) in
			DispatchQueue.main.async {
				do {
					let pokemon = try result.get()
					self?.pokemon = pokemon
				} catch {
					let alertVC = UIAlertController(error: error)
					self?.present(alertVC, animated: true)
				}
			}
		})
	}
}

extension PokemonSearchViewController: PokeSpriteCellDelegate {
	func pokeCell(_ cell: PokeSpriteCollectionViewCell, hadAnError error: Error) {
		let alertVC = UIAlertController(error: error)
		present(alertVC, animated: true)
	}
}

extension PokemonSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return spritesURLs?.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpriteCell", for: indexPath)
		guard let spriteCell = cell as? PokeSpriteCollectionViewCell else { return cell }

		spriteCell.delegate = self
		spriteCell.pokemonController = pokemonController
		spriteCell.spriteURLString = spritesURLs?[indexPath.item]

		return cell
	}
}
