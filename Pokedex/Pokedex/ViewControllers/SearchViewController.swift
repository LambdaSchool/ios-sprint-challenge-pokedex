//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Casualty on 9/15/19.
//  Copyright © 2019 Thomas Dye. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var pokemonLocationsLabel: UILabel!
    
    var apiController: APIController?
    var searchPokemon: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        hideViews()
        
        if let searchedPokemon = searchPokemon {
            title = searchedPokemon
            searchBar.isHidden = true
            performSearch(for: searchedPokemon)
        }
    }
    
    private func updateViews(with pokemon: Pokemon) {
        title = pokemon.name.capitalized
        pokemonIdLabel.text = "ID: \(pokemon.id)"
        pokemonNameLabel.text = "\(pokemon.name.capitalized)"
        pokemonHeightLabel.text = "Height: \(pokemon.height) dm"
        pokemonWeightLabel.text = "Weight: \(pokemon.weight) hg"
        pokemonLocationsLabel.text = pokemon.locationAreaEncounters
        
        pokemonAbilitiesLabel.text = "Abilities: \(pokemon.abilities.map{$0.ability.name.capitalized}.joined(separator: ", "))"
        pokemonTypesLabel.text = "Types: \(pokemon.types.map{$0.type.name.capitalized}.joined(separator: ", "))"
        pokemonImage.load(url: pokemon.sprites.frontShiny)
        
        showViews()
    }
    
    
    private func performSearch(for searchedPokemon: String) {
        apiController?.getPokemons(by: searchedPokemon) { ( result ) in
            guard let result = try? result.get() else { return }
            print(result)
            DispatchQueue.main.async {
                self.updateViews(with: result)
            }
        }
    }
    
    private func hideViews() {
        pokemonImage.isHidden = true
        pokemonIdLabel.isHidden = true
        pokemonTypesLabel.isHidden = true
        pokemonHeightLabel.isHidden = true
        pokemonWeightLabel.isHidden = true
        pokemonAbilitiesLabel.isHidden = true
        pokemonLocationsLabel.isHidden = true
        saveButton.isEnabled = false
    }
    
    private func showViews() {
        pokemonImage.isHidden = false
        pokemonIdLabel.isHidden = false
        pokemonTypesLabel.isHidden = false
        pokemonHeightLabel.isHidden = false
        pokemonWeightLabel.isHidden = false
        pokemonLocationsLabel.isHidden = false
        pokemonAbilitiesLabel.isHidden = false
        saveButton.isEnabled = true
    }
    
    // MARK: - IBActions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = title else { return }
        apiController?.addPokemon(pokemon: name)
        saveButton.isEnabled = false
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        performSearch(for: searchTerm)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
