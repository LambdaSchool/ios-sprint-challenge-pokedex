//
//  SearchDetailViewController.swift
//  Pokedex
//
//  Created by Thomas Cacciatore on 5/24/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController, UISearchBarDelegate {

    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
        searchBar.delegate = self
        
        if let _ = pokemon {
            updateViews()
            searchBar.isHidden = true
            saveButton.isHidden = true
        } else {
            hideLabels()
        }
    }
    
    private func hideLabels() {
        nameLabel.text = ""
        typesLabel.text = ""
        idLabel.text = ""
        abilitiesLabel.text = ""
        saveButton.isHidden = true
    }

    private func updateViews() {
        guard let pokemon = pokemon else { return }
        DispatchQueue.main.async {
            self.idLabel.text = "ID: \(String(pokemon.id))"
            self.nameLabel.text = pokemon.name.capitalizingFirstLetter()
            let types = pokemon.types.map( { $0.type.name })
            self.typesLabel.text = "Types: \(types.joined(separator: ", "))"
            let abilities = pokemon.abilities.map( { $0.ability.name } )
            self.abilitiesLabel.text = "Abilities: \(abilities.joined(separator: ", "))"
            let imageString = pokemon.sprites.frontDefault
            let imageURL = URL(string: imageString)
            let imageData = try! Data(contentsOf: imageURL!)
            let image = UIImage(data: imageData)
            self.pokemonImage.image = image
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController?.searchForPokemon(with: searchTerm)  { (error) in
            if let error = error {
                NSLog("Error searching for pokemon: \(error)")
                return
            }
            guard let pokemon = self.pokemonController?.pokemon else { return }

            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.saveButton.isHidden = false
            }
        
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController?.addPokemon(pokemon: pokemon)
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    
    var pokemonController: PokemonController?
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
