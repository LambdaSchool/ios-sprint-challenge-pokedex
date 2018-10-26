//
//  DetailVC.swift
//  Pokedex
//
//  Created by Nikita Thomas on 10/26/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit


class DetailVC: UIViewController {
    

    @IBOutlet weak var baseExperienceLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var theWeightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    var pokemon: Pokemon?
    
    func updateViews(pokemon: Pokemon) {
        baseExperienceLabel.text = "\(pokemon.baseExperience)"
        nameLabel.text = pokemon.name
        theWeightLabel.text = "\(pokemon.weight)"
        heightLabel.text = "\(pokemon.height)"
        
        ImageLoader.fetchImage(from: URL(string: "\(pokemon.sprites.frontDefault)")) { (image) in
            guard let image = image else {return}
            DispatchQueue.main.async {
                self.image.image = image
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let hasPokemon = pokemon else {return}
        updateViews(pokemon: hasPokemon)
    }
}
