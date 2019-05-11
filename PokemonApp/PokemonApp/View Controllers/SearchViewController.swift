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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateViews()
    }

     


    private func updateViews() {
        guard let pokemon = pokemon else { return }

        idLabel.text = "\(pokemon.id)"

        let convertedTypeString = pokemon.types.map { $0.name}
        typeLabel.text = "\(convertedTypeString)"

        let convertedAbilityString = pokemon.abilities.map {$0.name}
        abilityLabel.text = "\(convertedAbilityString)"


        

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }

        pokemonController?.fetchPokemon(with: searchTerm.lowercased(), completion: { (pokemon, error) in
            if let error = error {
                NSLog("Error finding pokemon: \(error)")
                return
            }

            if let pokemon = pokemon {

                DispatchQueue.main.async {
                //should put the pokemon back on the main thread and show info
                self.pokemon = pokemon
                self.updateViews()
            }

                self.pokemonController?.fetchImage(at: pokemon, completion: { (image, error) in
                    if let error = error {
                        NSLog("Error getting images from pokemon: \(error)")
                        return
                    }
                    DispatchQueue.main.async {
                        self.imageView.image = image

                    }
                })
            }
        })
    }


    


    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }

        pokemonController?.create(pokemon: pokemon)
        navigationController?.popToRootViewController(animated: true)
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






