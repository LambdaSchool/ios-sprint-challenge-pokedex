//
//  PokedexDetailViewController.swift
//  Pokedex
//
//  Created by macbook on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PokedexDetailViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var apiController: APIController?
    var pokemon: Pokemon?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        if let pokemon = pokemon,
            let pokemonName = searchBar.text,
            !pokemonName.isEmpty {

            apiController?.pokemonList.append(pokemon)
            self.navigationController?.popToRootViewController(animated: true)

        } else { return }
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text else { return }
        getDetails(for: searchTerm)
    }
    
    func getDetails(for pokemonName: String) {
        
        apiController?.fetchSearchedPokemon(with: pokemonName) { (result) in
            
            do {
                let pokemon = try result.get()
                
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    
                    //self.updateViews()
                    //title = pokemon.name
                    self.nameLabel.text = pokemon.name
                    self.idLabel.text = String(pokemon.id)
                    self.typesLabel.text = pokemon.types.map({ $0.type.name.capitalized }).joined(separator: ", ")
                    self.abilitiesLabel.text = pokemon.abilities.map({ $0.ability.name.capitalized}).joined(separator: ", ")
                }
                
                self.apiController?.fetchImage(at: pokemon.imageURL.frontDefault) { (image) in
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
                
            } catch {
                NSLog("Error fetching pokemon details: \(error)")
            }
        }
    }
    
    func updateViews() {
        
        if let pokemon = pokemon {
            title = pokemon.name
            nameLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
            typesLabel.text = pokemon.types.map({ $0.type.name.capitalized }).joined(separator: ", ")
            abilitiesLabel.text = pokemon.abilities.map({ $0.ability.name.capitalized}).joined(separator: ", ")
            searchBar.alpha = 0
            saveButton.alpha = 0
            self.apiController?.fetchImage(at: pokemon.imageURL.frontDefault) { (image) in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
            }
        }
    }
}
