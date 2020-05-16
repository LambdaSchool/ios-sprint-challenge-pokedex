//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Rob Vance on 5/15/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // Mark: IBOutlets
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    // Properties
    var pokemonAPIController: PokemonAPIController?
    var pokemon: Pokemon?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonSearchBar.becomeFirstResponder()
    }
    
    
    // Mark: IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        
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
