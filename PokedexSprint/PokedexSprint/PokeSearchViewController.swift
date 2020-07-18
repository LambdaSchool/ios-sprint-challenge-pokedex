//
//  PokeSearchViewController.swift
//  PokedexSprint
//
//  Created by John McCants on 7/17/20.
//  Copyright © 2020 John McCants. All rights reserved.
//

import UIKit

class PokeSearchViewController: UIViewController, UISearchBarDelegate {
    
    var pokemonController : PokemonController?
    var pokemonDataController : PokemonDataController?
    var pokemon : PokemonSearchResult?

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        hideViews()
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search tapped")
        
        print("\(searchBar.text)")
        guard let searchText = searchBar.text, let pokemonController = pokemonController else {return}
        pokemonController.searchPokemonByName(searchText: searchText.lowercased(), completion: {(result) in
            let pokemonInfo = try? result.get()
            if let pokemon = pokemonInfo {
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                }
            }
        })
        }
    
    func updateViews() {
        guard let pokemon = pokemon else {
            print("no pokemon")
            hideViews()
            title = "Pokemon Search"
            return }
        
        showViews()
        nameLabel.text = pokemon.name.capitalized
        abilitiesLabel.text = pokemon.getAbilitiesString()
        title = pokemon.name.capitalized
        
        
        
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        print("button tapped. \(pokemonDataController?.pokemonArray.first)")
        guard let pokemonDataController = pokemonDataController, let pokemonName = searchBar.text else {return}
        
        print(pokemonName)
        pokemonDataController.pokemonArray.append(Pokemon(pokemonName: pokemonName))
        
        pokemonDataController.saveToPersistenceStore()
        self.navigationController?.popViewController(animated: true)
        
        
    }
    func showViews() {
        nameLabel.isHidden = false
        abilitiesLabel.isHidden = false
        
    }
    
    func hideViews() {
        nameLabel.isHidden = true
        idLabel.isHidden = true
        abilitiesLabel.isHidden = true
        typesLabel.isHidden = true
        imageView.isHidden = true
        
        }
        

}
