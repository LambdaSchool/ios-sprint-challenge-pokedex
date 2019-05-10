//
//  SearchPokemonViewController.swift
//  Pokedex
//
//  Created by Christopher Aronson on 5/10/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class SearchPokemonViewController: UIViewController, UISearchBarDelegate {
    var pokemonController: PokemonController?

    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonSearchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = pokemonSearchBar.text else { return }
        guard let pokeController = pokemonController else { return }
        
        pokeController.search(for: text) { (result) in
            do {
                let thisPokemon = try result.get()
            }
            catch {
                print(error)
            }
        }
        
    }

    @IBAction func savePokemonButtonTapped(_ sender: Any) {
    }
}
