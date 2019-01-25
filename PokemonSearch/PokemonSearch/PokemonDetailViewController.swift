//
//  PokemonDetailViewController.swift
//  PokemonSearch
//
//  Created by Jocelyn Stuart on 1/25/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
        
    var pokemonController: PokemonController?
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    
    func updateViews() {
        
        if let pokemon = pokemon, isViewLoaded {
            nameLabel.text = pokemon.name
            idLabel.text = "ID: \(pokemon.id)"
            typeLabel.text = "Abilities: " + pokemon.abilities.map({ $0.ability.name}).joined(separator: ", ")
            abilitiesLabel.text = "Types: " + pokemon.types.map({ $0.type.name }).joined(separator: ", ")
            
            navigationItem.title = pokemon.name
            
        }
    }

}
