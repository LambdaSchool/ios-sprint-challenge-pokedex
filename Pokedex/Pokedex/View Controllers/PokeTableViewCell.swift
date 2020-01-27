//
//  PokeTableViewCell.swift
//  Pokedex
//
//  Created by Alexander Supe on 12/8/19.
//  Copyright © 2019 Alexander Supe. All rights reserved.
//

import UIKit

class PokeTableViewCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    
    //Attributes
    var pokemon: Pokemon? { didSet{ updateViews() } }
    
    //Lifecycle
    func updateViews() {
        guard let pokemon = pokemon else { return }
        label.text = pokemon.name.capitalized
        
        //Image
        guard let pokeImg = try? Data(contentsOf: pokemon.sprites.frontDefault) else { return }
        pokeImage.image = UIImage(data: pokeImg)
    }
}
