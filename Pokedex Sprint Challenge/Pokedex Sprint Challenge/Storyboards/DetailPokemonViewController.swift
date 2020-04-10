//
//  DetailPokemonViewController.swift
//  Pokedex Sprint Challenge
//
//  Created by Mark Poggi on 4/10/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

import UIKit

class DetailPokemonViewController: UIViewController {
    
    var pokemon: Pokemon?
    var searchPokemonController: SearchPokemonController?
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name
            idLabel.text = pokemon.id
            typesLabel.text = pokemon.type
            abilitiesLabel.text = pokemon.ability
            //            imagePokemon = pokemon.imageURL
            
        }
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
