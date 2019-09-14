//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Bobby Keffury on 9/14/19.
//  Copyright © 2019 Bobby Keffury. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    //MARK: - Properties
    
    var pokemonController: PokemonController?
    var pokemon: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    //updateViews
    private func updateViews(with pokemon: Pokemon) {
        title = pokemon.name
        titleLabel.text = pokemon.name
        idLabel.text = "\(pokemon.id)"
        typesLabel.text = pokemon.types
        abilitiesLabel.text = pokemon.abilities
        
    }

    
}
