//
//  PokemonSearchViewController.swift
//  PokedexSprint3
//
//  Created by Jaspal on 1/25/19.
//  Copyright © 2019 Jaspal Suri. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonSearchBar.delegate = self
    }
    
    @IBOutlet weak var pokemonTitleName: UINavigationItem!
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonTypes: UILabel!
    @IBOutlet weak var pokemonAbilities: UILabel!
    @IBOutlet weak var pokemonSprite: UIImageView!
    
    @IBAction func savePokemon(_ sender: Any) {
        PokedexModel.shared.savePokemon()
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        searchBar.text = ""
        searchBar.placeholder = searchTerm
        
        func updateSearchResults() {
            
            guard let presentedPokemon = PokedexModel.shared.selectedPokemon else { fatalError("Could not obtain Pokemon.")}
            
            pokemonTitleName.title = presentedPokemon.name
            pokemonName.text = presentedPokemon.name
            pokemonID.text = "ID: \(presentedPokemon.id)"
            pokemonTypes.text = "Types: \(presentedPokemon.types.compactMap({$0.type.name}).joined(separator: ", "))"
            pokemonAbilities.text = "Abilities: \(presentedPokemon.abilities.compactMap({$0.ability.name}).joined(separator: ", "))"
            
            guard let urlString = presentedPokemon.sprites?.frontDefault else { return }
            
            guard let imageURL = URL(string: urlString), let imageData = try? Data(contentsOf: imageURL) else { fatalError("Couldn't obtain image.")}
            pokemonSprite?.image = UIImage(data: imageData)
            
        }
        
        pokemonSearchResultsController.performSearch(searchTerm: searchTerm) { _ in
            DispatchQueue.main.async {
                updateSearchResults()
            }
        }
    }
    
    // MARK: Properties
    
    let pokemonSearchResultsController = PokemonSearchResultsController()

}
