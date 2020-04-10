//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Dahna on 4/10/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImage: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBAction func savePokemonButtonTapped(_ sender: UIButton) {
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
