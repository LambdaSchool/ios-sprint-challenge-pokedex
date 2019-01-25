//
//  SearchPokemonViewController.swift
//  Pokedex
//
//  Created by Moses Robinson on 1/25/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class SearchPokemonViewController: UIViewController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        addButton.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController?.searchForPokemon(searchTerm: searchTerm, completion: { (pokemon, error) in
            if let error = error {
                NSLog("error finding pokemon with \(searchTerm): \(error)")
                return
            }
            self.pokemon = pokemon ?? nil
        })
    }
    
    @IBAction func addPokemonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController?.createPokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        addButton.isHidden = false
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        typeLabel.text = "Types: \(pokemon.types.first?.type.name.capitalized ?? "Unknown")"
        abilityLabel.text = "Abilities: \(pokemon.abilities.first?.ability.name.capitalized ?? "Unknown")"
        pokemonController?.fetchImage(for: pokemon, completion: { (data) in
            guard let data = data else { return }
            let image = UIImage(data: data)
            self.imageView.image = image
        })
    }
    
    // MARK: - Properties
    
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    var pokemonController: PokemonController?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
}
