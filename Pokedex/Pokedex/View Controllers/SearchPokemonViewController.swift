//
//  SearchPokemonViewController.swift
//  Pokedex
//
//  Created by Jordan Davis on 5/24/19.
//  Copyright © 2019 Jordan Davis. All rights reserved.
//

import UIKit

class SearchPokemonViewController: UIViewController, UISearchBarDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.delegate = self
        updateViews()
    }
    
    //MARK: - Actions
    
    @IBAction func save(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController?.save(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK: - Functions
    
    func updateViews() {
        guard let pokemon = pokemon, isViewLoaded else {
            title = "Pokemon Search"
            return }
        
        title = pokemon.name.capitalized
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        
        let type = pokemon.types.map { $0.type.name }.joined(separator: ", ")
        typesLabel.text = "Type(s): \((type).capitalized)"
        
        let abilities = pokemon.abilities.map { $0.ability.name }.joined(separator: ", ")
        abilitiesLabel.text = "Abilites: \((abilities).capitalized)"
        
        //I know I'm supposed to load my image in here, but I could not figure it out in time so that the image reloads from my tableview cell
        
    
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let name = searchBar.text, !name.isEmpty else { return }
        
        pokemonController?.fetchPokemon(with: name, completion: { (returnedPokemon, error) in
            if let error = error {
                NSLog("Error fetching pokemon: \(error)")
                return
            }
            
            if let pokemon = returnedPokemon {
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                }
                
                self.pokemonController?.fetchSprite(with: pokemon, completion: { (image, error) in
                    if let error = error {
                        NSLog("Error retrieving image: \(error)")
                        return
                    }
                    
                    if let image = image {
                        DispatchQueue.main.async {
                            self.imageView.image = image
                            self.saveButton.setTitle("Save \(pokemon.name.capitalized)", for: .normal)
                        }
                    }
                })
            }
        })
        
    }
    
    
    //MARK: - Properties
    
    var pokemonController: PokemonController?
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
}
