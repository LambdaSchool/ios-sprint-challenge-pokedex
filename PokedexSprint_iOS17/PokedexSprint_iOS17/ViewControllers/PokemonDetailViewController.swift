//
//  PokemonDetailViewController.swift
//  PokedexSprint_iOS17
//
//  Created by Stephanie Ballard on 5/8/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // MARK: - Outlets -
    
    // MARK: - Properties -
    var pokemonApiController: PokemonApiController?
    var pokemon: Pokemon?
    
    // MARK: - Lifecycle Functions -
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
//        searchbar.delegate = self
    }
    
    // MARK: - Actions -
    
    // MARK: - Helper Methods -
    func updateViews() {
        
    }
    

}
