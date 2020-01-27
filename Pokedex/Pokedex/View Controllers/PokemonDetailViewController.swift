//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by David Wright on 1/26/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // MARK: - Properties

    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var spriteImageView: UIImageView!
    
    // MARK: - Methods

    func updateViews() {
        guard let pokemon = pokemon, isViewLoaded else { return }
        
        nameLabel.text = pokemon.name
        idLabel.text = String(pokemon.id)
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
}
