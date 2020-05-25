//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Clean Mac on 5/18/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonName :UILabel!
    @IBOutlet weak var pokemonImage :UIImageView!
    @IBOutlet weak var pokemonID :UILabel!
    @IBOutlet weak var pokemonType :UILabel!
    @IBOutlet weak var pokemonAblilities :UILabel!


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
