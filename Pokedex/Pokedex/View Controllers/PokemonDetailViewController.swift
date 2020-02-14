//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Keri Levesque on 2/14/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    //MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
  
    
    //MARK: Properties
    
    var pokemonController: PokemonController!
    var pokemon: Pokemon?
   
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
   //MARK: Methods
    func updateViews(with pokemon: Pokemon) {
            nameLabel.text = pokemon.name
            idLabel.text = "\(pokemon.id)"
            typesLabel.text = pokemon.types
            abilitiesLabel.text = pokemon.abilities
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
