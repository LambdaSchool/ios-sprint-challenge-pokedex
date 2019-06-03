//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Stephanie Bowles on 6/2/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var pokeNameLabel: UILabel!
    
    @IBOutlet weak var spriteView: UIImageView!
    
    @IBOutlet weak var pokeIDLabel: UILabel!
    @IBOutlet weak var pokeTypesLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController : PokemonController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
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
        guard let pokemon = pokemon else {return}
        pokeNameLabel.text = pokemon.name.capitalized
        let id = String(pokemon.id)
        pokeIDLabel.text = "ID: \(id)"
        let type: [String] = pokemon.types.map { $0.type.name }
        pokeTypesLabel.text = "Type(s): \(type.joined(separator: ", "))"
        let abilities: [String] = pokemon.abilities.map { $0.ability.name }
        abilitiesLabel.text = "Abilities: \n\(abilities.joined(separator: "\n"))"
        guard let url = URL(string: pokemon.sprites.front_default),
            let pokemonImageData = try? Data(contentsOf: url) else { return }
        spriteView.image = UIImage(data: pokemonImageData)
        
        
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        pokemonController?.savePokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
  
    
  
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        print("Search clicked")
        
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
