//
//  PokemonSearchDetailViewController.swift
//  Pokedex
//
//  Created by Craig Swanson on 11/10/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import UIKit

class PokemonSearchDetailViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: Properties
    let pokemonController = PokemonController()
    
    // MARK: Outlets
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeID: UILabel!
    @IBOutlet weak var pokeType: UILabel!
    @IBOutlet weak var pokeAbility: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions
    @IBAction func savePokemon(_ sender: UIButton) {
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
