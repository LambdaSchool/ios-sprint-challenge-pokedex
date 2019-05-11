//
//  PokeSpriteCollectionViewCell.swift
//  Pokesearch
//
//  Created by Michael Redig on 5/10/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class PokeSpriteCollectionViewCell: UICollectionViewCell {

	@IBOutlet var spriteView: UIImageView!
	var pokemonController: PokemonController?
	private var imageId: String?
	var spriteURLString: String? {
		didSet {
			fetchImage()
		}
	}

	func fetchImage() {
		guard let spriteURLString = spriteURLString, let url = URL(string: spriteURLString) else { return }
		let newImageId = UUID().uuidString
		imageId = newImageId
		pokemonController?.getSprite(withURL: url, requestID: newImageId, completion: { [weak self] (result) in
			do {
				let (requestId, image) = try result.get()
				if self?.imageId == requestId {
					DispatchQueue.main.async {
						self?.spriteView.image = image
					}
				}
			} catch {
				print("image fetch error: \(error)")
			}
		})
	}
}
