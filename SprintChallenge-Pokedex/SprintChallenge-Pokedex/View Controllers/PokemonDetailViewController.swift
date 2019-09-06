//
//  PokemonDetailViewController.swift
//  SprintChallenge-Pokedex
//
//  Created by Ciara Beitel on 9/6/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var apiController: APIController?

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pokeImage: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

