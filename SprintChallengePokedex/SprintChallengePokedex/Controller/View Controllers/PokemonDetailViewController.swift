//
//  PokemonDetailViewController.swift
//  SprintChallengePokedex
//
//  Created by Chad Rutherford on 12/6/19.
//  Copyright © 2019 lambdaschool.com. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeSpriteImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    var apiController: APIController!
    var pokemon: Pokemon?
    var typeString = ""
    var abilitiesString = ""
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViews()
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - View Presentation
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name.capitalized
        self.title = pokemon.name.capitalized
        idLabel.text = "\(pokemon.id)"
        for (index, type) in pokemon.types.enumerated() {
            if index == 1 {
                typeString += " / " + type.type.name.capitalized
            } else {
                typeString += type.type.name.capitalized
            }
        }
        typesLabel.text = typeString
        for (index, ability) in pokemon.abilities.enumerated() {
            if index == pokemon.abilities.count - 1 {
                abilitiesString += ability.ability.name.capitalized
            } else {
                abilitiesString += ability.ability.name.capitalized + ", "
            }
        }
        abilitiesLabel.text = abilitiesString
        apiController.fetchImage(at: pokemon.sprites.frontDefault) { result in
            if let image = try? result.get() {
                self.pokeSpriteImageView.image = image
            }
        }
    }
}
