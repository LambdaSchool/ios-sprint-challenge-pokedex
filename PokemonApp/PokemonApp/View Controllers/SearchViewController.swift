//
//  SearchViewController.swift
//  PokemonApp
//
//  Created by Diante Lewis-Jolley on 5/17/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        idLabel.text = ""
        typeLabel.text = ""
        abilityLabel.text = ""


    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }

        pokemonController.fetchPokemon(with: searchTerm.lowercased()) { (pokemon, error) in
            if let error = error {
                NSLog("Error searching pokemon: \(error)")
                return
            }

            if let pokemon = pokemon {
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                }

                self.pokemonController.fetchImages(pokemon: pokemon, completion: { (image, error) in
                    if let error = error {
                        NSLog("Error searching Images: \(error)")
                        return
                    }

                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                })
            }
        }

    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }

        pokemonController.create(pokemon: pokemon)

        let alertController = UIAlertController(title: "Pokemon Saved!", message: "Your pokemon was successfully Saved!", preferredStyle: .alert)

         alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            self.navigationController?.popToRootViewController(animated: true) }))

        present(alertController, animated: true, completion: nil)
    }

    private func updateViews() {

        guard let pokemon = pokemon else { return }
        idLabel.text = "ID: \(pokemon.id)"
        typeLabel.text = "Type: \(pokemon.types.map {$0.type.name})"
        abilityLabel.text = "Abilities: \(pokemon.abilities.map {$0.ability.name})"

    }
    
    


    let pokemonController = PokemonController()
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }



}
