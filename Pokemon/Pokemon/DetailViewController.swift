//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Yvette Zhukovsky on 10/26/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//


import UIKit

class DetailViewController: UIViewController, UISearchBarDelegate {
    var pokemonController: PokedexController?
    var poke: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchB.delegate = self
        updateViews()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchEntry = searchB.text else {return}
        pokemonController?.fetchPokemon(name: searchEntry, completion: {
            (pokemon, error) in
            
            if let error = error {
                NSLog("error getting pokemon:\(error)")
                return
            }
            
            self.poke = pokemon
            
            DispatchQueue.main.async {
                self.updateViews()
            }
        })
    }
    
    func updateViews() {
        if let pokemon = poke {
            self.title = pokemon.name
            idLabel?.text = "ID: \(String(pokemon.id))"
            typeLabel?.text = "Type: \(poke?.types.map({$0.type.name}).joined(separator:" , ") ?? "")"
            abilitiesLabel?.text = "Abilities: \(poke?.abilities.map({$0.ability.name}).joined(separator:" , ") ?? "")"
            saveButton.setTitle("Save Pokemon", for: .normal)
            self.pokeImage.image = pokemon.image
        } else {
            self.title = "Pokemon Search"
            idLabel?.text = ""
            typeLabel?.text = ""
            abilitiesLabel?.text = ""
            saveButton.setTitle("", for: .normal)
            
            
            
        }
        
        
    }
    
    
    
    
    @IBOutlet weak var searchB: UISearchBar!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    
    @IBAction func savePokemon(_ sender: Any) {
        if let poke = poke {
            pokemonController?.savePokemons(pokemon: poke)
        }
    }
    
    
    @IBOutlet weak var pokeImage: UIImageView!
    
    
    @IBOutlet weak var saveButton: UIButton!
}








