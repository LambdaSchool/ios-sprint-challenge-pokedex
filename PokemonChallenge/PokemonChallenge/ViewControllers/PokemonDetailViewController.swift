//
//  PokemonDetailViewController.swift
//  PokemonChallenge
//
//  Created by Ryan Murphy on 5/17/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
        }
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonStackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        updateViews()
    }
    
    
    
    private func updateViews() {
        
        if let pokemon = pokemon {
            
            nameLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
            abilitiesLabel.text = ""
            typesLabel.text = ""
            
            for ability in pokemon.abilities {
                abilitiesLabel.text?.append(contentsOf: ability.ability.name)
                abilitiesLabel.text?.append(contentsOf: ". ")
            }
            
            for type in pokemon.types {
                typesLabel.text?.append(contentsOf: type.type.name)
                typesLabel.text?.append(contentsOf: ". ")
            }
            
            navigationItem.title = pokemon.name
            
            pokemonStackView.isHidden = false
        } else {
            navigationItem.title = "Search"
            pokemonStackView.isHidden = true
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        guard let pokemon = pokemon else { return }
        
        pokemonController?.pokemonInPokedex.append(pokemon)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let name = searchBar.text?.lowercased(),
            !name.isEmpty
            else { return }
        
        pokemonController?.fetchPokemon(named: name, completion: { (pokemon, error) in
      
            if let error = error {
                NSLog("Error \(error)")
                DispatchQueue.main.async {
                    self.pokemon = nil
                }
                return
            }
            
            guard let pokemon = pokemon else {
                NSLog("Error finding pokemon")
                return
            }
            
            self.pokemonController?.fetchImage(at: pokemon.sprites.frontDefault, completion: { (image, error) in
                if let error = error {
                    NSLog("Error \(error)")
                    return
                }
                
                guard let image = image else {
                    NSLog("Error finding image")
                    return
                }
                
                pokemon.imageData = image.pngData()
                if let pokemonImage = pokemon.imageData {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: pokemonImage)
                    }
                  
                }
                
                
            })
            
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.updateViews()
            }
        })
        
        searchBar.text = ""
    }
}

