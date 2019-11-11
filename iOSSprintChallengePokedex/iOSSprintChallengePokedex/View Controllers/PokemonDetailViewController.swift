//
//  PokemonDetailViewController.swift
//  iOSSprintChallengePokedex
//
//  Created by denis cedeno on 11/9/19.
//  Copyright © 2019 DenCedeno Co. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    var pokemonController: PokemonController?
    
    var pokemon: Pokemon? {
        didSet{
            updateViews()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var saveButtonProperties: UIButton!
    @IBOutlet weak var attributesLabel: UILabel!
    
    @IBAction func savePokemon(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        pokemonController?.save(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        updateViews()
    }
    
    func updateViews() {
        guard let searchedPokemon = pokemon, isViewLoaded else {
            title = "Search for a Pokemon"
            return
        }
        title = searchedPokemon.name
        idLabel.text = String(searchedPokemon.id)
        let types = searchedPokemon.types.map { $0.type.name }.joined(separator: ",")
        typesLabel.text = types
        let abilities = searchedPokemon.abilities.map {$0.ability.name}.joined(separator: ",")
        attributesLabel.text = abilities
        
        saveButtonProperties.isHidden = true
        searchBar.isHidden = true
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let name = searchBar.text, !name.isEmpty else { return }
        
        pokemonController?.fetchPokemon(for: name.lowercased(), completion: {(_, pokemon)   in
            guard let pokemon = pokemon else { return }
            self.pokemon = pokemon
            self.pokemonController?.fetchSprite(with: pokemon, completion: { (pokemonImage) in
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.imageView.image = pokemonImage
                }
            })
        })
    }
}

