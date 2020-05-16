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
    var pokemonImage: UIImage?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
            pokemonController?.fetchImage(urlString: pokemon?.sprites.frontDefault ?? "", completion: { (result) in
                       if let pokemonSearchResult = try? result.get() {
                           DispatchQueue.main.async {
                            self.pokemonImage = pokemonSearchResult
                            self.updateViews()
                           }
                       }
                   })
        }
    }
    
    private func updateViews() {
        guard let pokemon = pokemon,
            let pokemonController = pokemonController else { return }
        
        pokemonNameLabel.text = pokemon.name
        self.pokemonImageView.image = pokemonImage
    }

}
