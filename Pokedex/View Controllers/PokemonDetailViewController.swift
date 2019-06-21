//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Kat Milton on 6/21/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var pokemonIDLabel: UILabel!
    @IBOutlet var pokemonTypesLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    @IBOutlet var spriteDisplay: UIImageView!
    
    var pokemon: Pokemon?
    
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
