//
//  PokemonDetailViewController.swift
//  PokedexSprint3
//
//  Created by Jaspal on 1/25/19.
//  Copyright © 2019 Jaspal Suri. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonTypes: UILabel!
    @IBOutlet weak var pokemonAbilities: UILabel!
    @IBOutlet weak var pokemonSprite: UIImageView!
    @IBOutlet weak var pokemonTitleName: UINavigationItem!
    
}
