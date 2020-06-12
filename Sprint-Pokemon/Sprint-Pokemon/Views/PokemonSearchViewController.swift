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
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        NotificationCenter.default.post(name: .pokemonSaved, object: sender.isSelected)
        
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
    
    override func encodeRestorableState(with coder: NSCoder) {
        // Our super class to encode and info it needs
        super.encodeRestorableState(with: coder)
        // Make sure you have something to save.
        // Property list is a file that is helpful in saving configurations (XML)
        guard let existingPokemon = pokemon else { return }
        
        do {
            let pokemonData = try PropertyListEncoder().encode(existingPokemon)
            coder.encode(pokemonData, forKey: "pokemonData")
        } catch {
            print(error)
            return
        }
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        guard let pokemonData = coder.decodeObject(forKey: "pokemonData") as? Data else { return }
        
        do {
            let savedPokemon = try PropertyListDecoder().decode(Pokemon.self, from: pokemonData)
            pokemon = savedPokemon
        } catch {
            print(error)
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
