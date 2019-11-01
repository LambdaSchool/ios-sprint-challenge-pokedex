//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Brandi on 11/1/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var apiController: APIController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    
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
    
    private func updateViews() {
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name
            abilitiesLabel.text = "\(pokemon.abilities)"
            typesLabel.text = "\(pokemon.types)"
            idLabel.text = "\(pokemon.id)"
        }
        
    }

}
