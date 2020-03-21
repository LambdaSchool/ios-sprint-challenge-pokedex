//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Chad Parker on 3/20/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    var pokemon: Pokemon!
    var apiController: APIController!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        getImage()
    }
    
    private func updateViews() {
        nameLabel.text = pokemon.name
        idLabel.text = "\(pokemon.id)"
        typesLabel.text = String(describing: pokemon.types)
        abilitiesLabel.text = String(describing: pokemon.abilities)
    }
    
    private func getImage() {
        
    }
}
