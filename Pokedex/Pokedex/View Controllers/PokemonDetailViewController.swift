//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Farhan on 9/14/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var typeLabwl: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?{
        didSet{
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        pokemonController?.fetchPokemon(name: searchText, completion: { (_, pokemon) in
            guard let pokemon = pokemon else { return }
            
            self.pokemonController?.createPokemon(pokemon: pokemon)
            
            self.pokemon = pokemon
            
        })
    }
    
    func updateView(){
        
        guard let pokemon = pokemon else { return }
        
        idLabel.text = String(pokemon.id)
        nameLabel.text = String(pokemon.name)
        
    }
}

    

   
    

