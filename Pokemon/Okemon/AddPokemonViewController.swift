//
//  AddPokemonViewController.swift
//  Okemon
//
//  Created by Jonathan Ferrer on 5/17/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import UIKit

class AddPokemonViewController: UIViewController {
    var pokemonController: PokemonController?

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let pokemon = pokemonController?.pokemon else { return }

        pokemonController?.addPokemon(name: pokemon.name, id: pokemon.id, abilities: pokemon.abilities, types: pokemon.types, sprites: pokemon.sprites)
    }



    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }

        pokemonController?.searchPokemon(with: searchTerm, completion: { (error) in
            if let error = error {
                NSLog("Error searching pokemon: \(error)")
                return
            } else {
                guard let pokemon = self.pokemonController?.pokemon else { return }
                self.nameLabel.text = pokemon.name
                self.idLabel.text = "\(pokemon.id)"
                self.typesLabel.text = "\(pokemon.types)"
                self.abilitiesLabel.text = "\(pokemon.abilities)"

                print(pokemon)


            }
        })

    }



}
