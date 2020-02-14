//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Tobi Kuyoro on 14/02/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var savePokemonButton: UIButton!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        searchBar.delegate = self
    }
    
    @IBAction func savePokemonTapped(_ sender: Any) {
        if let pokemonController = pokemonController,
            let pokemon = pokemon {
            pokemonController.save(pokemon: pokemon)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func updateViews() {
        guard let pokemon = pokemon else {
            title = "Pokemon Search"
            hideOutlets()
            return
        }
        
        showOutlets()
        searchBar.isHidden = true
        pokemonName.text = pokemon.name
        guard let imageData = try? Data(contentsOf: pokemon.sprites.picture) else { fatalError() }
        pokemonImage.image = UIImage(data: imageData)
        idLabel.text = "ID: \(pokemon.id)"
        
        var typesText: [String] = []
        var abilitiesText: [String] = []
        
        for pokemonType in pokemon.types {
            typesText.append(pokemonType.type.name)
        }
        
        for pokemonAbility in pokemon.abilities {
            abilitiesText.append(pokemonAbility.ability.name)
        }
        
        typesLabel.text = "Types: \(typesText.joined(separator: ", ").capitalized)"
        abilitiesLabel.text = "Abilities: \(abilitiesText.joined(separator: ",").capitalized)"
        savePokemonButton.isHidden = false
    }
    
    func hideOutlets() {
        pokemonName.isHidden = true
        pokemonImage.isHidden = true
        pokemonImage.isHidden = true
        idLabel.isHidden = true
        typesLabel.isHidden = true
        abilitiesLabel.isHidden = true
        savePokemonButton.isHidden = true
    }
    
    func showOutlets() {
        pokemonName.isHidden = false
        pokemonImage.isHidden = false
        pokemonImage.isHidden = false
        idLabel.isHidden = false
        typesLabel.isHidden = false
        abilitiesLabel.isHidden = false
        savePokemonButton.isHidden = false
    }
}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonName = searchBar.text else { return }
        
        pokemonController?.findPokemon(called: pokemonName, completion: { (result) in
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
