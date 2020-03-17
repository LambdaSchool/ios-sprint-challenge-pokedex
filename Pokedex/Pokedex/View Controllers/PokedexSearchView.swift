//
//  PokedexSearchView.swift
//  Pokedex
//
//  Created by Lotanna Igwe-Odunze on 11/2/18.
//  Copyright © 2018 Lotanna. All rights reserved.
//

import Foundation
import UIKit

class PokedexSearch: UIViewController, UISearchBarDelegate {
    //Referencing Properties
    var pokeMaster: PokemonManager?

    
    //Load the view data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokeSearchBar.delegate = self
        loadPokemonResult()

    }
    
    //Outlets
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var foundPokeName: UILabel!
    @IBOutlet weak var foundPokeID: UILabel!
    @IBOutlet weak var foundPokePhoto: UIImageView!
    @IBOutlet weak var foundPokeAbility: UILabel!
    @IBOutlet weak var foundPokeType: UILabel!
    
    //Perform the Search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let pokeQuery = pokeSearchBar.text else { return } //Unwrap
        
        //Below is the JSON action that pulls the searched term from the API.
        PokemonImporter().getPokemon(searchedPokemon: pokeQuery, completion: { (error) in
            if let error = error {
                NSLog("Something is wrong with search: \(error)") //Message for log
                return
            }
            DispatchQueue.main.async { //Makes this happen in the background
                self.loadPokemonResult() //Calls function that displays results on reload.
            }
        }) //End of Getting Pokemon
    }
    
    //Display the found pokemon
    func loadPokemonResult() {
        if let pokemon = foundPokemon {
            foundPokeName.text = pokemon.name
            foundPokeID.text = "\(pokemon.id)"
            foundPokeAbility.text = pokemon.abilities.first?.ability.name
            foundPokeType.text = pokemon.types.first?.pokemonType.name
            //foundPokePhoto.image?.pngData() = pokemon.image
        } else {
            foundPokeName.text = "Not found"
            foundPokeID.text = "Not found"
            foundPokeAbility.text = "Not found"
            foundPokeType.text = "Not found"
        }
    }
    
    @IBAction func savePokeButton(_ sender: UIButton) {
        pokeMaster?.newPokemon() //Create a new pokemon on save
    }
}
