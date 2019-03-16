//
//  PokeMonDetailViewController.swift
//  Pokedex
//
//  Created by Iyin Raphael on 9/21/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class PokeMonDetailViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //updateView()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        pokeController?.fetchPokemon(name: searchTerm, completion: { (pokemon, error) in
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.updateView()
            }
        })
    }
    
    var pokemon: Pokemon?{
        didSet{
            updateView()
        }
    }
    
    func updateView(){
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name
            typesLabel.text = pokemon.types[0].type.name
            abilityLabel.text = pokemon.abilities[0].ability.name
            idLabel.text = String(pokemon.id)
        }
        
    }

    
    @IBAction func savePokemon(_ sender: Any) {
        guard let pokemonNew = pokemon else {return}
        pokeController?.create(pokemon: pokemonNew)
        navigationController?.popViewController(animated: true)
    }
    var pokeController: PokemonController?
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
}
