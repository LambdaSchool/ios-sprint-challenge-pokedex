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
    var pokemonController: PokemonController? // TODO: Eliminate
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
                searchBar.removeFromSuperview()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    /// Load the Pokemon object into the view
    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        nameLabel?.text = pokemon.name
        idLabel?.text = "ID: \(pokemon.id)"
        typeLabel?.text = "Types: \(pokemon.id)"
        abilityLabel?.text = "Abilities: \(pokemon.id)"

        // Load the Pokemon pic
//        if pokemonImageView.image == nil {
//            self.pokemonController?.fetchImage(for: pokemon., completion: { result in
//                if let image = try? result.get() {
//                    DispatchQueue.main.async {
//                        self.pokemonImageView.image = image
//                    }
//                }
//            })
//        }
    }

    func performSearch() {
        guard let searchTerm = searchBar.text else { return }

        pokemonController?.findPokemon(named: searchTerm) { result in
            if let foundPokemon = try? result.get() {
                DispatchQueue.main.async {
                    self.pokemon = foundPokemon
                }
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }
}
