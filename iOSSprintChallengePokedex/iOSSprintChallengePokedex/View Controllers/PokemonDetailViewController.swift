//
//  PokemonDetailViewController.swift
//  iOSSprintChallengePokedex
//
//  Created by denis cedeno on 11/9/19.
//  Copyright © 2019 DenCedeno Co. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    var pokemonController: PokemonController? {
        didSet {
            updateViews()
        }
    }
    
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
    @IBOutlet weak var attributesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
   
    @IBAction func savePokemon(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        pokemonController?.save(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        searchBar.delegate = self
    }
    
    func updateViews() {
        guard let searchedPokemon = pokemon,
            isViewLoaded else {
            title = "Search for a Pokemon"
                idLabel.text = ""
                nameLabel.text = ""
                typesLabel.text = ""
                attributesLabel.text = ""
                saveButton.isEnabled = false
            return
        }
        title = searchedPokemon.name.capitalized
        idLabel.text = String(searchedPokemon.id)
        let types = searchedPokemon.types.map { $0.type.name }.joined(separator: ",")
        typesLabel.text = types
        let abilities = searchedPokemon.abilities.map {$0.ability.name}.joined(separator: ",")
        attributesLabel.text = abilities
        
        pokemonController?.fetchSprite(from: searchedPokemon.sprite.imageURL, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.imageView.image = pokemonImage
            }
        })
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let name = searchBar.text, !name.isEmpty else { return }
        pokemonController?.fetchPokemon(name: name, completion: { (result) in
            guard let pokemon = try? result.get() else { return }
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        })
        guard let pokemonImgUrl = pokemon?.sprite.imageURL else { return }
        pokemonController?.fetchSprite(from: pokemonImgUrl, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.imageView.image = pokemonImage
            }
        })
 
    }
}

