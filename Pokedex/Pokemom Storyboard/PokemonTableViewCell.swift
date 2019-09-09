//
//  PokemonTableViewCell.swift
//  Pokemom Storyboard
//
//  Created by Alex Rhodes on 9/7/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    let ui = UIController()
    
    var pokemon: Pokemon? {
        didSet {
            setViews()
        }
    }

    func setViews() {
        
        
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

        guard let pokemon = pokemon else {return}
        
        nameLabel.text = pokemon.name
        idLabel.text = String(pokemon.id)
        let url = URL(string: pokemon.sprites.frontDefault)!
        if let image = try? Data(contentsOf: url) {
        photo.image = UIImage(data: image)
        }
    }
}
