//
//  SearchDetailViewController.swift
//  Pokedex
//
//  Created by Gi Pyo Kim on 10/4/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var ability: UILabel!
    
    var pokemonController: PokemonController!
    var pokemon: Pokemon! {
        didSet {
            DispatchQueue.main.async {
                self.updateViews(with: self.pokemon)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokeSearchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if pokemon != nil {
            pokeSearchBar.alpha = 0.0
            saveButton.alpha = 0.0
        } else {
            pokeSearchBar.alpha = 1.0
            pokeNameLabel.alpha = 0.0
            id.alpha = 0.0
            type.alpha = 0.0
            ability.alpha = 0.0
            saveButton.alpha = 0.0
        }
    }
    
    func updateViews(with pokemon: Pokemon) {
        if isViewLoaded {
            pokeNameLabel.alpha = 1.0
            id.alpha = 1.0
            type.alpha = 1.0
            ability.alpha = 1.0
            saveButton.alpha = 1.0
            
            title = pokemon.name.capitalized
            pokeNameLabel.text = pokemon.name.capitalized
            idLabel.text = String(pokemon.id)
            
            for i in pokemon.types.indices {
                typeLabel.text! += pokemon.types[i].type.name + ((i == pokemon.types.count-1) ? "" : ", ")
            }
            
            for i in pokemon.abilities.indices {
                abilityLabel.text! += pokemon.abilities[i].ability.name + ((i == pokemon.abilities.count-1) ? "" : ", ")
            }
            
            pokemonController.fetchImage(at: pokemon.sprites.front_default) { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                        self.pokeImageView.image = image
                    }
                } else {
                    NSLog("Error fetching image")
                }
            }
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let name = searchBar.text, !name.isEmpty else { return }
        
        pokemonController.searchPokemon(name: name) { (result) in
            do {
                self.pokemon = try result.get()
                DispatchQueue.main.async {
                    self.resignFirstResponder()
                }
            } catch {
                NSLog("Error fetching pokemon: \(error)")
            }
        }
        
    }
    
    @IBAction func SaveButtonTabbed(_ sender: UIButton) {
        pokemonController.savePokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
}
