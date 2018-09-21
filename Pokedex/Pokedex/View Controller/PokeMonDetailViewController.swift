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
        updateView()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        pokeController?.fetchPokemon(name: searchTerm, completion: { (error) in
            if let error = error {
                NSLog("Error fetching pokemon: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.updateView()
            }
        })
    }
    
    func updateView(){
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name
            typesLabel.text = pokemon.types[0].type[0].name
            abilityLabel.text = pokemon.abilities[0].ability[0].name
            idLabel.text = String(pokemon.id)
        }else {
            navigationItem.title = "Search Pokemon"
            nameLabel.text = " "
            typesLabel.text = " "
            abilityLabel.text = " "
            idLabel.text = " "
        }
    }

    
    @IBAction func savePokemon(_ sender: Any) {
        guard let pokemonNew = pokemon else {return}
        pokeController?.create(pokemon: pokemonNew)
    }
    
    var pokemon: Pokemon?{
        didSet{
            updateView()
        }
    }
    var pokeController: PokemonController?
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
}
