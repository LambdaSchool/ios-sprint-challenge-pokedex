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
        guard let pokemon = pokemon else { return }
        
        pokemonController?.pokemon.append(pokemon)
        
        navigationController?.popViewController(animated: true)
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

        searchBar.delegate = self

        // Do any additional setup after loading the view.
        if pokemon == nil {
            // Hide pokemon stack view
        } else {
            updateViews()
            
            if viewing {
                saveButtonLabel.isHidden = true
                searchBar.isHidden = true
            } else {
                saveButtonLabel.isHidden = false
                searchBar.isHidden = false
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        updateViews()
    }
    
    /// Load the Pokemon object into the view
    func updateViews() {
        if let pokemon = pokemon {
            if viewing {
                title = pokemon.name
            }
            nameLabel?.text = pokemon.name
            idLabel?.text = "ID: \(pokemon.id)"
            
            // Create Type Label
            var types = "Types: "
            for item in pokemon.types {
                types += item.type.name + ", "
            }
            typeLabel?.text = types
            
            // Create Ability Label
            var abilities = "Abilities: "
            for item in pokemon.abilities {
                abilities += item.ability.name + ", "
            }
            abilityLabel?.text = abilities

            if !viewing {
                saveButtonLabel?.isHidden = false
            }
            
            // Load the Pokemon pic
            let hack = "https://user-images.githubusercontent.com/16965587/57208109-357e8000-6f8f-11e9-911d-9ec9b245d35f.jpg"
            if pokemonImageView?.image == nil {
                self.pokemonController?.fetchImage(for: hack, completion: { result in
                    do {
                        let image = try result.get()
                        DispatchQueue.main.async {
                            self.pokemonImageView?.image = image
                        }
                    } catch {
                        if let error = error as? NetworkError {
                            switch error {
                            case .noAuth:
                                NSLog("No bearer token exists")
                            case .badAuth:
                                NSLog("Bearer token invalid")
                            case .otherNetworkError:
                                NSLog("Other error occurred, see log")
                            case .badData:
                                NSLog("No data received, or data corrupted")
                            case .noDecode:
                                NSLog("JSON could not be decoded")
                            case .badUrl:
                                NSLog("URL invalid")
                            }
                        }
                    }
                })
            }
        } else {
            nameLabel?.text = ""
            idLabel?.text = ""
            typeLabel?.text = ""
            abilityLabel?.text = ""
            pokemonImageView?.image = nil
            saveButtonLabel.isHidden = true
        }
    }

    func performSearch() {
        guard let searchTerm = searchBar.text?.lowercased(),
            !searchTerm.isEmpty else { return }

        viewing = false
        pokemon = nil
        updateViews()
        
        pokemonController?.findPokemon(named: searchTerm) { result in
            do {
                let foundPokemon = try result.get()
                DispatchQueue.main.async {
                    self.pokemon = foundPokemon
                }
            } catch {
                var message = ""
                if let error = error as? NetworkError {
                    switch error {
                    case .noAuth:
                        message = "No bearer token exists"
                    case .badAuth:
                        message = "Bearer token invalid"
                    case .otherNetworkError:
                        message = "Other error occurred, see log"
                    case .badData:
                        message = "No data received, or data corrupted"
                    case .noDecode:
                        message = "JSON could not be decoded"
                    case .badUrl:
                        message = "URL invalid"
                    }
                    NSLog(message)
                }
                // TODO: Necessary to dispatch it?
                DispatchQueue.main.async {
                    self.nameLabel?.text = message
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
