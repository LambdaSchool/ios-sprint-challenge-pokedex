//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_204 on 11/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Properties
    var pokemonResultController: PokemonResultController?
    var pokemon: PokemonResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    private func updateViews() {
        if let pokemon = pokemon {
            title = pokemon.name
            nameLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
            abilitiesLabel.text = pokemon.abilities.map({$0.ability.name}).joined(separator: ", ")
            typesLabel.text = pokemon.types.map({$0.type.name}).joined(separator: ", ")
            fetchImage(from: pokemon)
            saveButton.isHidden = true
            searchBar.isHidden = true
        } else {
            title = "Pokemon Search"
        }
    }

    private func searchResults () {
        guard let pokemonResultController = pokemonResultController,
            let searchTerm = searchBar.text,
            !searchTerm.isEmpty else { return }
        
        pokemonResultController.performSearch(for: searchTerm.lowercased()) { result in
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.title = pokemon.name
                    self.nameLabel.text = pokemon.name
                    self.idLabel.text = String(pokemon.id)
                    self.abilitiesLabel.text = pokemon.abilities.map({$0.ability.name}).joined(separator: ", ")
                    self.typesLabel.text = pokemon.types.map({$0.type.name}).joined(separator: ", ")
                    self.fetchImage(from: pokemon)
                }
            } catch {
                print("Error getting pokemon! \(error)")
                
            }
        }
    }
    
    private func fetchImage(from pokemon: PokemonResult) {
        guard let pokemonResultController = pokemonResultController else { return }
        
        pokemonResultController.fetchImage(at: pokemon.sprites.frontDefault) { imageResult in
            do {
                let image = try imageResult.get()
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            } catch {
                print("Error with image \(error)")
            }
        }
    }
    
    @IBAction func saveTapped(_ sender: UIButton){
        guard let pokemonResultController = pokemonResultController,
            let pokemon = pokemon else { return }
        pokemonResultController.savePokemon(with: pokemon)
        self.navigationController?.popViewController(animated: true)
    }
}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResults()
    }
}
