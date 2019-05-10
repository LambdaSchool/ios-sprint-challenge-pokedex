//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Lisa Sampson on 5/10/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Properties and Outlets
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    // MARK: - View Loading Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        updateViews()
    }
    
    func updateViews() {
        if let pokemon = pokemonController?.pokemon {
            title = pokemon.name
            nameLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
            typeLabel.text = pokemon.types.first?.type.name
            abilitiesLabel.text = pokemon.abilities.first?.ability.name
        } else {
            title = "Pokemon Search"
            nameLabel.text = "Pokemon"
            idLabel.text = ""
            typeLabel.text = ""
            abilitiesLabel.text = ""
        }
    }
    
    // MARK: - Actions and Search Bar Delegate Methods
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemonController?.pokemon else { return }
        pokemonController?.create(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm  = searchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController?.fetch(searchName: searchTerm, completion: { (error) in
            if let error = error {
                NSLog("There was an error fetching the data: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.updateViews()
            }
            
//            self.pokemonController?.fetchImage(at: (self.pokemon?.sprites.frontDefault)!, completion: { (image, error) in
//                if let error = error {
//                    NSLog("There was an error fetching the image: \(error)")
//                    return
//                }
//
//                DispatchQueue.main.async {
//                    self.pokemonImage.image = image
//                    self.updateViews()
//                }
//            })
        })
    }
}
