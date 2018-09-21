//
//  PokeMonTableViewCell.swift
//  Pokedex
//
//  Created by Iyin Raphael on 9/21/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class PokeMonTableViewCell: UITableViewCell {
    
    func updateView(){
        if let pokemon = pokemon{
            nameLabel.text = pokemon.name
            guard let imageURL = URL(string: pokemon.sprites[0].spriteName) else {return}
            guard let data = try? Data(contentsOf: imageURL) else {return}
            pokeImageView.image = UIImage(data: data)
        }
    }
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?{
        didSet{
            updateView()
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeImageView: UIImageView!
    

}
