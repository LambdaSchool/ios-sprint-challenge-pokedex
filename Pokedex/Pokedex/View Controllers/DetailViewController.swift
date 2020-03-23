//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Matthew Martindale on 3/22/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let pokemonController = PokemonController()
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        searchBar.delegate = self
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
    }
    
    func updateViews() {
        var types = ""
        pokemon?.types.forEach { pokemon in
            types.append("\(pokemon.type.name) ")
        }
        
        var abilities = ""
        pokemon?.abilities.forEach { pokemon in
            abilities.append("\(pokemon.ability.name) ")
        }
        
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name
            idLabel.text = "ID: \(pokemon.id)"
            typesLabel.text = "Type: \(types)"
            abilitiesLabel.text = "Abilities: \(abilities)"
            getPokemonImage()
        }
    }
    
    func getPokemonImage() {
        guard let pokemonSprite = pokemon?.sprites.frontDefault else { return }
        if let url = URL(string: pokemonSprite) {
            do {
                let data = try Data(contentsOf: url)
                self.pokemonImageView.image = UIImage(data: data)
            } catch let err {
                print("Error loading sprite image: \(err.localizedDescription)")
            }
        }
    }

}

extension DetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text,
        !searchTerm.isEmpty {
            pokemonController.searchPokemon(for: searchTerm) { result in
                do {
                    let pokemon = try result.get()
                    DispatchQueue.main.async {
                        self.pokemon = pokemon
                    }
                } catch {
                    if let error = error as? NetworkError {
                        switch error {
                        case .noAuth:
                            print("Error: No bearer token exists.")
                        case .badAuth:
                            print("Error: Bearer token invalid.")
                        case .noData:
                            print("Error: The response had no data.")
                        case .decodeFailure:
                            print("Error: The data could not be decoded.")
                        case .otherError(let otherError):
                            print("Error: \(otherError)")
                        }
                    } else {
                        print("Error: \(error)")
                    }
                }
            }
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
