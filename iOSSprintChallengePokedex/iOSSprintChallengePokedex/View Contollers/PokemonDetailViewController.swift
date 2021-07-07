//
//  PokemonDetailViewController.swift
//  iOSSprintChallengePokedex
//
//  Created by denis cedeno on 11/13/19.
//  Copyright © 2019 DenCedeno Co. All rights reserved.
//
import UIKit

class PokemonDetailViewController: UIViewController {
    
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    var pokemonController: PokemonController? {
        didSet {
            updateViews()
        }
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        searchBar.delegate = self
    }
    
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else {return}
        pokemonController?.addPokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard isViewLoaded else {return}
        guard let searchedPokemon = pokemon else {
            title = "Search for a Pokemon"
            idLabel.text = ""
            nameLabel.text = ""
            typeLabel.text = ""
            abilityLabel.text = ""
            saveButton.isHidden = true
            return
        }
        
        title = searchedPokemon.name.capitalized
        nameLabel.text = pokemon?.name
        idLabel.text = "ID: \(searchedPokemon.id)"
        saveButton.isHidden = false
        var types: [String] = []
        for typeInfo in searchedPokemon.types {
            types.append(typeInfo.type.name)
        }
        
        typeLabel.text = "Types: \(types.joined(separator: ", "))"
        abilityLabel.text = "Ability: \(searchedPokemon.abilities[0].ability.name)"
        
        pokemonController?.fetchImage(from: searchedPokemon.sprites.imageUrl) { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}


extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ sender: UISearchBar) {
        
        guard let searchTerm = searchBar.text else { return }
        
        pokemonController?.fetchPokemon(name: searchTerm) { pokemon in
            guard let pokemon = try? pokemon.get() else { return }
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        }
        
        guard let pokemonImgUrl = pokemon?.sprites.imageUrl else {return}
        
        pokemonController?.fetchImage(from: pokemonImgUrl) { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        
    }
}
