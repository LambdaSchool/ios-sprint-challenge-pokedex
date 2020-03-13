//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Mark Gerrior on 3/13/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var pokemonStackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var saveButtonLabel: UIButton!
    
    // MARK: - Actions
    @IBAction func saveButton(_ sender: Any) {
    }
    
    // MARK: - Properites
    var viewing = false
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if pokemon == nil {
            // Hide pokemon stack view
            pokemonStackView.removeFromSuperview()
        } else {
            // Show pokemon stack view
            updateViews()
            
            if viewing {
                saveButtonLabel.removeFromSuperview()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    /// Load the Pokemon object into the view
    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        nameLabel.text = pokemon.name
        // FIXME:
        //pokemonImageView: UIIm
        idLabel.text = "ID: \(pokemon.id)"
        typeLabel.text = "Types: \(pokemon.id)"
        abilityLabel.text = "Abilities: \(pokemon.id)"
    }
}
