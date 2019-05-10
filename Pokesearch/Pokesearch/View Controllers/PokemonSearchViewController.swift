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

	var pokemonController: PokemonController?
	var pokemon: Pokemon? {
		didSet {
			updateViews()
		}
	}
	private var spritesURLs: [String]?

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		showViews(show: false)
		updateViews()
	}

	func updateViews() {
		guard let pokemon = pokemon, isViewLoaded else { return }
		showViews(show: true)
		pokemonNameLabel.text = pokemon.name
		pokemonIDLabel.text = "\(pokemon.id)"
		typeLabel.text = pokemon.types.reduce ("") { $0 + $1.type.name + " " }
		abilitiesLabel.text = pokemon.abilities.reduce("") { $0 + $1.ability.name + " " }
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


extension PokemonSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return spritesURLs?.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpriteCell", for: indexPath)
		guard let spriteCell = cell as? PokeSpriteCollectionViewCell else { return cell }

		spriteCell.pokemonController = pokemonController
		spriteCell.spriteURLString = spritesURLs?[indexPath.item]

		return cell
	}


}
