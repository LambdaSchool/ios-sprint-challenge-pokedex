//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Andrew Ruiz on 10/4/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func savePokemonButtonTapped(_ sender: Any) {
    }
    
}
