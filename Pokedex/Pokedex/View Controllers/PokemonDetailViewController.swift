//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Mitchell Budge on 5/17/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    var pokemonController: PokemonController?
    var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilityLabel: UILabel!

}
