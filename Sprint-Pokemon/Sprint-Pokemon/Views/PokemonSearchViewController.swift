//
//  PokemonSearchViewController.swift
//  Sprint-Pokemon
//
//  Created by Breena Greek on 3/20/20.
//  Copyright © 2020 Breena Greek. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    // MARK: - Properties
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    var pokemonController: PokemonController?
    
    // MARK: - IBOutlets
    @IBOutlet weak var spriteNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spriteImage: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        
        pokemonController?.addPokemon(pokemon: pokemon)
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        searchBar.delegate = self
    }
    
    
    func updateViews() {
        
        guard isViewLoaded else { return }
        guard let pokemon = pokemon else {
            self.title = "Add New Pokemon"
            saveButton.setTitle("Save", for: .normal)
            return
        }
        
        self.title = pokemon.name
        self.spriteNameLabel.text = pokemon.name
        self.idLabel.text = String("ID: \(pokemon.id)")
        self.abilitiesLabel.text = "Abilities: " + pokemon.abilities.map({$0.ability.name}).joined(separator: ", ")
        self.typeLabel.text = "Types: " + pokemon.types.map({$0.type.name}).joined(separator: ", ")
        
        self.pokemonController!.fetchImage(at: pokemon.sprites.imageURL) { (result) in
            guard let image = try? result.get() else { return }
            
            DispatchQueue.main.async {
                self.spriteImage.image = image
            }
        }
    }
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        pokemonController!.performSearch(searchTerm: searchTerm) { (result) in
            
            guard let pokemon = try? result.get() else { return }
            
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
            self.pokemonController!.fetchImage(at: pokemon.sprites.imageURL) { (result) in
                guard let image = try? result.get() else { return }
                
                DispatchQueue.main.async {
                    self.spriteImage.image = image
                }
            }
        }
    }
}
