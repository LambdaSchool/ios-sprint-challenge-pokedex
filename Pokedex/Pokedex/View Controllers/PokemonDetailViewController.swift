//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Claudia Contreras on 3/20/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // MARK: - Properties
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet var pokemonSearchBar: UISearchBar!
    @IBOutlet var PokemonView: UIView!
    @IBOutlet var pokemonLabel: UILabel!
    @IBOutlet var pokemonImage: UIImageView!
    @IBOutlet var pokemonIDLabel: UILabel!
    @IBOutlet var pokemonTypeLabel: UILabel!
    @IBOutlet var pokemonAbilitiesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        pokemonSearchBar.delegate = self
    }
    
    // MARK: - IBActions
    @IBAction func savePokemonButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Functions
    func updateViews() {
        guard let pokemon = pokemon else {
            title = "Pokemon Search"
            hideUIView()
            return
        }
        
        showUIView()
        pokemonSearchBar.isHidden = true
        pokemonLabel.text = pokemon.name.capitalized
        guard let imageData = try? Data(contentsOf: pokemon.sprites.defaultImageURL) else { fatalError() }
        pokemonImage.image = UIImage(data: imageData)
        pokemonIDLabel.text = "ID: \(pokemon.id)"
        
        var typesText: [String] = []
        var abilitiesText: [String] = []
        
        for pokemonType in pokemon.types {
            typesText.append(pokemonType.type.name)
        }
        for pokemonAbility in pokemon.abilities {
            abilitiesText.append(pokemonAbility.ability.name)
        }
        
        pokemonTypeLabel.text = "Types: \(typesText.joined(separator: ", ").capitalized)"
        pokemonAbilitiesLabel.text = "Abilities: \(abilitiesText.joined(separator: ", ").capitalized)"
        
    }
    
    func hideUIView() {
        
    }
    func showUIView() {
        
    }
}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonName = pokemonSearchBar.text else { return }
        pokemonController?.getPokemon(with: pokemonName, completion: { (result) in
            let pokemon = try? result.get()
            if let pokemon = pokemon {
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                }
            }
        })
    }
}
