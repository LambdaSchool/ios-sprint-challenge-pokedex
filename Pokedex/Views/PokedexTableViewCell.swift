//
//  PokedexTableViewCell.swift
//  Pokedex
//
//  Created by Chris Price on 5/16/20.
//  Copyright © 2020 com.chrispriiice. All rights reserved.
//

import UIKit

class PokedexTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let pokemon = pokemon,
            let pokemonController = pokemonController else { return }
        
        pokemonNameLabel.text = pokemon.name
        let image: UIImage = pokemonController.fetchImage(urlString: pokemon.sprites.frontDefault, completion: { (result) -> Void in
            if let pokemonSearchResult = try? result.get() {
                DispatchQueue.main.async {
                    self.pokemonImageView.image = pokemonSearchResult
                }
            }
        }) ?? UIImage()
        pokemonImageView.image = image
    }

}
