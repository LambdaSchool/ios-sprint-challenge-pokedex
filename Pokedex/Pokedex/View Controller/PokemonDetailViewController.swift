//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Juan M Mariscal on 3/20/20.
//  Copyright © 2020 Juan M Mariscal. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesTextView: UITextView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    
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
