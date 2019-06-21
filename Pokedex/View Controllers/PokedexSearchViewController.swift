//
//  PokedexSearchViewController.swift
//  Pokedex
//
//  Created by Kat Milton on 6/21/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import UIKit

class PokedexSearchViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var pokemonSprite: UIImageView!
    @IBOutlet var pokemonIDLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    @IBOutlet var saveButton: UIButton!

    var pokemonController: PokemonController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        pokemonNameLabel.text = ""
        saveButton.setTitle("", for: .normal)
        pokemonIDLabel.text = ""
        typeLabel.text = ""
        abilitiesLabel.text = ""
        title = "Search for Pokémon"
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        title = pokemon.name.capitalized
        pokemonNameLabel.text = pokemon.name.capitalized
        let id = String(pokemon.id)
        pokemonIDLabel.text = "ID: \(id)"
        let type: [String] = pokemon.types.map { $0.type.name }
        typeLabel.text = "Type(s): \(type.joined(separator:", ").capitalized)"
        let abilities: [String] = pokemon.abilities.map { $0.ability.name }
        abilitiesLabel.text = "Abilities: \(abilities.joined(separator: ", ").capitalized)"
        guard let url = URL(string: pokemon.sprites.front_default),
            let spriteData = try? Data(contentsOf: url) else { return }
        pokemonSprite.image = UIImage(data: spriteData)
        saveButton.setTitle("Save Pokemon", for: .normal)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        pokemonController?.savePokemon(pokemon: pokemon)
        print("Saving pokemon: \(pokemon.name)")
        navigationController?.popViewController(animated: true)
        
    }


}

extension PokedexSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        print("Searching")
        
        pokemonController?.fetchPokemon(for: searchTerm, completion: { (result, error) in
            if error != nil {
                NSLog("Error searching for: \(String(describing: error))")
            }
            self.pokemon = result
            DispatchQueue.main.async {
                self.updateViews()
                self.searchBar.text = ""
            }
        })
    }
}
