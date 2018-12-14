//
//  PokemonSearchViewController.swift
//  PokeDex
//
//  Created by Vijay Das on 12/14/18.
//  Copyright © 2018 Vijay Das. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
// Outlets
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    
//    @IBOutlet weak var spritePokemon: SKView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // searchbar delegate
        pokemonSearchBar.delegate = self
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
