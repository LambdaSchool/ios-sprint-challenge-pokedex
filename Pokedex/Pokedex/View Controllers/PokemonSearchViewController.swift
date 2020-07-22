//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Sammy Alvarado on 7/20/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLablel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var apiController: APIController?
    var pokemonN: String?

    var pokemon: Pokemon? {
        didSet {
            updateViews(with: pokemon!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        hiddenView()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        searchBar.resignFirstResponder()

        apiController?.fetchPokemon(for: searchTerm) { (pokemon) in
            guard let searchedPokemon = try? pokemon.get() else { return }
            DispatchQueue.main.async {
                self.pokemon = searchedPokemon
            }
        }
    }

    func getDetails() {
        guard let apiController = apiController,
            let animalName = pokemonN else { return }

        apiController.fetchPokemon(for: animalName) { (result) in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                }
                apiController.fetchPokemonImage(at: pokemon.sprites.absoluteString) { (result) in
                    if let image = try? result.get() {
                        DispatchQueue.main.async {
                            self.pokemonImageView.image = image
                        }
                    }
                }
            case .failure(let error):
                print("Error Fetching pokemon Detials \(error)")
            }
        }
    }
    
    func hiddenView() {
        saveButton.isEnabled = false
        nameLabel.isHidden = true
        idLablel.isHidden = true
        typesLabel.isHidden = true
        abilitiesLabel.isHidden = true
    }
    
    func updateViews(with pokemon: Pokemon) {
        guard isViewLoaded else { return }

        saveButton.isEnabled = true
        nameLabel.isHidden = false
        idLablel.isHidden = false
        typesLabel.isHidden = false
        abilitiesLabel.isHidden = false
        title = pokemon.name.capitalized
        guard let pokemonImageData = try? Data(contentsOf: pokemon.sprites) else {return}
        pokemonImageView.image = UIImage(data: pokemonImageData)
        nameLabel.text = pokemon.name.capitalized
        idLablel.text = "ID: \(String(pokemon.id))"
        
        var types = " "
        let typeArray = pokemon.types
        for type in typeArray {
            types.append(type.capitalized)
        }
        typesLabel.text = "Types: \(types)"
        
        var abilities = " "
        let abilityArray = pokemon.abilities
        for ability in abilityArray {
            abilities.append(ability.capitalized)
        }
        abilitiesLabel.text = "Abilities: \(abilities)"
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemonSaved = pokemon else { return }
        apiController?.addPokemon(pokemon: pokemonSaved)
        navigationController?.popToRootViewController(animated: true)
    }

}

