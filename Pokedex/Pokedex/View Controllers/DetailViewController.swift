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
    
    private func getPokemon() {
        guard let pokemonController = pokemonController, let pokemon = pokemon else {
            return
        }
        
        pokemonController.searchForPokemon(with: pokemon) { (result) in
            do {
                // call updateviews
                // call fetch image
                
            } catch {
                // switch the networkerror
            }
        }
    
        
    }
    
    
    //updateViews

    
}
