//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_241 on 3/20/20.
//  Copyright © 2020 Lambda_School_Loaner_241. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // Mark:- IBOutlets/Properties
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    var pokemonNames: String!
    var pokemonController: PokemonController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Mark:- Private Methods
    private func getDetails(){
        
    }
    

  

}
