//
//  PokemonDetailViewController.swift
//  Pokedex (Sprint Challenge)
//
//  Created by Nathan Hedgeman on 7/12/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    //Propeties
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    //Labels
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idDetailsLabel: UILabel!
    
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var typeDetailsLabel: UILabel!
    
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var abilityDetailsLabel: UILabel!

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
