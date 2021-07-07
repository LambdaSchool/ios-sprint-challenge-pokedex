//
//  SearchPokemonViewController.swift
//  Pokedex
//
//  Created by Moses Robinson on 1/25/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class SearchPokemonViewController: UIViewController, UISearchBarDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.delegate = self
        addButton.isHidden = true
        imageView.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController?.searchForPokemon(searchTerm: searchTerm, completion: { (pokemon, error) in
            if let error = error {
                NSLog("error finding pokemon with \(searchTerm): \(error)")
                return
            }
            self.pokemon = pokemon
            
            guard let url = pokemon?.sprites.frontDefault else { return }
            self.pokemonController?.fetchImage(url: url , completion: { (data) in
                self.pokemon?.imageData = data
            })
        })
        self.searchBar.endEditing(true)
    }
    
    @IBAction func addPokemonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController?.createPokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard let pokemon = pokemon,
            let imageData = pokemon.imageData else { return }
        
        addButton.isHidden = false
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        
        let typeString = pokemon.types.map {$0.type.name.capitalized}.joined(separator: "/")
        typeLabel.text = "Types: \(typeString)"
        
        let abilityString = pokemon.abilities.map {$0.ability.name.capitalized}.joined(separator: ", ")
        abilityLabel.text = "Abilities: \(abilityString)"
        
        imageView.isHidden = false
        imageView.image = UIImage(data: imageData)
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
