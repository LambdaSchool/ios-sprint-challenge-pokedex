//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Sameera Leola on 12/21/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    @IBOutlet weak var allElementsStack: UIStackView!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!

    @IBOutlet weak var pokemonIDText: UITextField!
    @IBOutlet weak var pokemonTypeText: UITextField!
    @IBOutlet weak var pokemonAbilitiesText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonSearchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func pokemonSave(_ sender: Any) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        pokemonSearchBar.autocapitalizationType = .none
        pokemonSearchBar.resignFirstResponder()
        guard let findThisPokemon = pokemonSearchBar.text?.lowercased(), !findThisPokemon.isEmpty else { return }
        
        // Clear the searchbar and set the placeholder text
        searchBar.text = ""
        searchBar.placeholder = findThisPokemon.lowercased()
        
        NetworkData.shared.searchForPokemon(with: findThisPokemon) { (error) in
            if let error = error {
                NSLog("could not call fetchPokemon method in pokemonSearchViewController: \(error)")
                return
            }
            DispatchQueue.main.async {
                // First, make sure we have a Pokemon
                guard let pokemon = NetworkData.shared.pokemonAPI else { return }
                // We have a Pokemon so populate the fields
                self.pokemonNameLabel.text = pokemon.name
                self.pokemonIDText.text = "\(pokemon.id)"
                let pokemonTypes = pokemon.types.map({$0.type.name.capitalized}).joined(separator: ", ")
                self.pokemonTypeText.text = pokemonTypes
                let pokemonAbilities = pokemon.abilities.map({$0.ability.name.capitalized}).joined(separator: ", ")
                self.pokemonAbilitiesText.text = pokemonAbilities
                
                // Show the Pokemon
                self.allElementsStack.isHidden.toggle()
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} // End of class
