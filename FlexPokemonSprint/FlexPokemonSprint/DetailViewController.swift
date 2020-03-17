//
//  DetailViewController.swift
//  FlexPokemonSprint
//
//  Created by admin on 10/4/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var iDLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    
    var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViews(with: pokemon)
    }
    
    func setViews(with pokemon: Pokemon?) {
        
        guard let pokemon = pokemon else { return }
        
        nameLabel.text = pokemon.name
        
        let url = URL(string: pokemon.sprites.frontDefault)!
        if let image = try? Data(contentsOf: url) {
            imageView.image = UIImage(data: image)
        }
        
        iDLabel.text = String(pokemon.id)
        
        var types = ""
        let typeArray = pokemon.types
        
        for type in typeArray {
            types.append("\(type.type.name)")
            types.append("\n")
        }

        typesLabel.text = types
        
        var abilities = ""
        let abilityArray = pokemon.abilities
        
        for ability in abilityArray {
            abilities.append("\(ability.ability.name)")
            abilities.append("\n")
        }
        
        abilitiesLabel.text = abilities
    }

}
