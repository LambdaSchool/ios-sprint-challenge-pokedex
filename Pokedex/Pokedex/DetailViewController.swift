//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Nathanael Youngren on 1/25/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "\(pokemon.id)"
        
        let abilityName = pokemon.abilities.map { $0.ability.name }
        let typeName = pokemon.types.map { $0.type.name }
        
        abilitiesLabel.text = abilityName.first
        typesLabel.text = typeName.first
    }
    
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
}
