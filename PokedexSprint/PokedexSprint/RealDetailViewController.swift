//
//  RealDetailViewController.swift
//  PokedexSprint
//
//  Created by Jorge Alvarez on 1/17/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import UIKit

class RealDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var apiController: ApiController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard isViewLoaded else {return}
        guard let pokemon = pokemon else {return}
        title = pokemon.name?.capitalized
        nameLabel.text = pokemon.name?.capitalized
        idLabel.text = "ID: \("\(pokemon.id!)")"
        typesLabel.text = "Types: " + pokemon.types.map( { $0.type.name.capitalized } ).joined(separator: ", ")
        abilitiesLabel.text = "Abilities: " + pokemon.abilities.map( { $0.ability.name.capitalized } ).joined(separator: ", ")
        guard let imageData = try? Data(contentsOf: pokemon.sprites.front_default) else {return}
        imageView.image = UIImage(data: imageData)
    }
}
