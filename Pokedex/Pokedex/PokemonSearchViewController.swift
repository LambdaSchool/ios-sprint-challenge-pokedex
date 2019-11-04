//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Rick Wolter on 11/3/19.
//  Copyright © 2019 Richar Wolter. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController,UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        search()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        search()
    }
    
    
    
    @IBAction func savePokemon(_ sender: Any) {
        guard let pokemon = pokemon else {return}
        print("we have a pokemon\(pokemon)")
        pokemonController?.pokemonArray.append(pokemon)
    }
    
    
    private func updateViews() {
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name
            title = pokemon.name
            
            idLabel.text = "ID: " + String(pokemon.id)
            abilitiesLabel.text = "Abilities: " + pokemon.abilities.map({$0.ability.name}).joined(separator: ", ")
            typeLabel.text = "Types: " + pokemon.types.map({$0.type.name}).joined(separator: ", ")
            fetchImage(from: pokemon)
           // saveButton.isHidden = true
            searchBar.isHidden = true
        } else {
            title = "Search for your Pokemon"
        }
    }

    
    func search(){
        print("In the search function")
        guard let pokemonController = self.pokemonController,
                let searchTerm = searchBar.text,
                !searchTerm.isEmpty else { return }
            print("There was a pokemonController in the search function")
            pokemonController.performSearch(for: searchTerm.lowercased()) { result in
                do {
                    let pokemon = try result.get()
                    DispatchQueue.main.async {
                        self.pokemon = pokemon
                        self.updateViews()
                        self.title = pokemon.name
                        self.nameLabel.text = pokemon.name
                        self.idLabel.text = String("ID: " + String(pokemon.id))
                        self.abilitiesLabel.text = "Abilities: " + pokemon.abilities.map({$0.ability.name}).joined(separator: ", ")
                        self.typeLabel.text = "Types: " + pokemon.types.map({$0.type.name}).joined(separator: ", ")
                        self.fetchImage(from: pokemon)
                        print("Coming back from seach")
                    }
                } catch {
                    print("Error finding the Pokemon. Got this error -> \(error)")
     
                }
            }
        }
    private func fetchImage(from pokemon: Pokemon) {
        guard let pokemonController = pokemonController else { return }
        
        pokemonController.fetchImage(at: pokemon.sprites.front_default) { imageResult in
            do {
                let image = try imageResult.get()
                DispatchQueue.main.async {
                    self.pokemonImageView.image = image
                }
            } catch {
                print("Error with image \(error)")
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

}
