//
//  AddPokemonViewController.swift
//  Okemon
//
//  Created by Jonathan Ferrer on 5/17/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import UIKit

class AddPokemonViewController: UIViewController, UISearchBarDelegate {
    var pokemonController: PokemonController?
    var pokemon: Pokemon?

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        updateViews()
        // Do any additional setup after loading the view.
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController?.pokemons.append(pokemon)

        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }

    func updateViews() {
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
            navigationItem.title = pokemon.name



            for type in pokemon.types {
                typesLabel.text?.append(contentsOf: type.type.name)
                typesLabel.text?.append(contentsOf: ", ")
            }
            for ability in pokemon.abilities {
                abilitiesLabel.text?.append(contentsOf: ability.ability.name)
                abilitiesLabel.text?.append(contentsOf: ", ")
            }

        } else {
            navigationItem.title = "Search"

        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text,
        !searchTerm.isEmpty else { return }

        pokemonController?.searchPokemon(with: searchTerm, completion: { (error) in
            if let error = error {
                NSLog("Error searching pokemon: \(error)")
                return
            }

                guard let pokemon = self.pokemonController?.pokemon else { return }

            self.pokemonController?.getImage(image: pokemon.sprites.frontDefault, completion: { (image, error) in
                if let error = error {
                    NSLog("Error \(error)")
                    return
                }
                guard let image = image else {
                    NSLog("Error fetching image")
                    return
                }
                pokemon.imageData = image.pngData()
                if let pokemonImage = pokemon.imageData {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: pokemonImage)
                    }
                }
            })
                print(pokemon)

            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.updateViews()
            }

        })

    }



}
