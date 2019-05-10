//
//  SearchViewController.swift
//  PokemonApp
//
//  Created by Diante Lewis-Jolley on 5/10/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {



    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }


    private func updateViews() {
        guard let pokemon = pokemon else { return }

        idLabel.text = "\(pokemon.id)"

        let convertedTypeString = pokemon.types.map { $0.name}
        typeLabel.text = "\(convertedTypeString)"

        let convertedAbilityString = pokemon.abilities.map {$0.name}
        abilityLabel.text = "\(convertedAbilityString)"

        guard let imageData = pokemon.imageData else { return }
        imageView.image = UIImage(data: imageData)

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }

        pokemonController?.fetchPokemon(with: searchTerm.lowercased(), completion: { (pokemon, error) in
            if let error = error {
                NSLog("Error finding pokemon: \(error)")
                return
            }

            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        })
    }
    


    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }

        pokemonController?.create(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    




    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }


}






