//
//  AddViewController.swift
//  Pokedex
//
//  Created by Lydia Zhang on 3/13/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var ability: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var pokemonController: PokemonController?

    
    var pokemon: Pokemon?{
        didSet{
            updateViews()
        }
    }
    var pokemonn: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if let pokemonController = pokemonController, let pokemon = pokemon {
            pokemonController.savePokemon(for: pokemon)
            navigationController?.popViewController(animated: true)
        }
    }
    func updateViews() {
        guard let pokemon = pokemon, isViewLoaded else {
            title = "Pokemon Search"
            return
        }
        
        pokemonController?.fetchPokemonImage(at: pokemon.sprites.front_default, completion: { result in
            if let images = try? result.get() {
                DispatchQueue.main.async {
                    self.image.image = images
                }
            }
        } )
        
        
        name.text = pokemon.name
        title = pokemon.name
        id.text = "\(pokemon.id)"
        
        let x = pokemon.types.map{$0.type.name}
        let types = x.joined(separator: ",")
        
        let y = pokemon.abilities.map{$0.ability.name}
        let abilities = y.joined(separator: ",")
        
        type.text = "\(types)"
        ability.text = "\(abilities)"
        searchBar.isHidden = true
    }
}

extension AddViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        pokemonController?.fetchPokemon(name: searchTerm, completion: { (result) in
            guard let pokemon = try? result.get() else { return }
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.saveButton.isHidden = false
            }
        })
    }
}
