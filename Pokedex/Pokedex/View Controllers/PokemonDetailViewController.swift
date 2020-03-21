//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Claudia Contreras on 3/20/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var pokemonSearchBar: UISearchBar!
    @IBOutlet var PokemonView: UIView!
    @IBOutlet var pokemonLabel: UIView!
    @IBOutlet var pokemonImage: UIImageView!
    @IBOutlet var pokemonIDLabel: UILabel!
    @IBOutlet var pokemonTypeLabel: UILabel!
    @IBOutlet var pokemonAbilitiesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    @IBAction func savePokemonButtonTapped(_ sender: Any) {
    }
    
}
