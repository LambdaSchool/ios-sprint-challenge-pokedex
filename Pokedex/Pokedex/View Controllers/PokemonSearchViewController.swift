//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Wyatt Harrell on 3/13/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    let pokemonController = PokemonController()
    #warning("--Why can't I pass this forward from TableView--")
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        
        print(pokemon.sprites.back_default)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController.pokedex.append(pokemon)
    }
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text else { return }
        
        pokemonController.searchPokemon(with: search.lowercased()) { (result) in
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                }
            } catch {
                if let error = error as? NetworkError {
                    switch error {
                    case .generic:
                        NSLog("Generic error")
                    case .statusCode:
                        NSLog("Bad status code")
                    case .noData:
                        NSLog("No data received")
                    case .decodeError:
                        NSLog("Data could not be decoded")
                    }
                }
            }
        }
    }
}
