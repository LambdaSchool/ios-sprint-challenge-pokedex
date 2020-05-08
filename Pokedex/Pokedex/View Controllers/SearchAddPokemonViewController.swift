//
//  SearchAddPokemonViewController.swift
//  Pokedex
//
//  Created by Kelson Hartle on 5/8/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import UIKit

class SearchAddPokemonViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameTitle: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController: PokemonController!
    var pokemon: Pokemon?
    
    
    @IBAction func savePokemonTapped(_ sender: Any) {
             
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()

    }
    
    
    func updateViews() {
        
        guard let pokemon = pokemon else { return }
        
        pokemonNameTitle.text = pokemon.name
        pokemonIdLabel.text = pokemon.id
        
        
        //pokemonImage.image = pokemon.
        //pokemonTypesLabel.text =
        abilitiesLabel.text = "\(pokemon.abilities)"
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
