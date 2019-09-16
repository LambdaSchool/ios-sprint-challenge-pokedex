//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Fabiola S on 9/13/19.
//  Copyright © 2019 Fabiola Saga. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: Properties
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    // MARK: Outlets
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var savePokemonButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchBar.delegate = self
        updateViews()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let enteredSearch = pokeSearchBar.text,
            !enteredSearch.isEmpty else { return }
        pokeSearchBar.text = ""
        
        pokemonController?.fetchPokemon(search: enteredSearch.lowercased(), completion: { (_, pokemon) in
            guard let pokemon = pokemon else { return }
            self.pokemon = pokemon
            self.pokemonController?.fetchImageFor(pokemon: pokemon, completion: { (_, pokemon) in
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                }
            })
        })
            
        
    }
    
    @IBAction func savePokemon(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        
        pokemonController?.savePokemon(pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    

    func updateViews() {
        guard isViewLoaded,
            let pokemon = pokemon else {
                title = "Search for Pokemon"
                pokemonNameLabel.text = ""
                idLabel.text = ""
                typesLabel.text = ""
                abilitiesLabel.text = ""
                savePokemonButton.isEnabled = false
                return
        }
        
        title = pokemon.name
        pokemonNameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        typesLabel.text = "Types: \(pokemon.allTypes)"
        abilitiesLabel.text = "Abilities: \(pokemon.allAbilities)"
        savePokemonButton.isEnabled = true
        if let imageData = pokemon.imageData {
            pokemonImage.image = UIImage(data: imageData)
        } else {
            pokemonImage.isHidden = true
        }
    }

}
