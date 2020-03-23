//
//  PokeSearchViewController.swift
//  Pokedex
//
//  Created by Juan M Mariscal on 3/20/20.
//  Copyright © 2020 Juan M Mariscal. All rights reserved.
//

import UIKit

class PokeSearchViewController: UIViewController {
    
    var apiController = APIController()
    var pokemon: Pokemon?
    
    // MARK: IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UITextView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonLabel.isHidden = true
        idLabel.isHidden = true
        pokemonTypeLabel.isHidden = true
        abilitiesLabel.isHidden = true
        
        
        searchBar.delegate = self
        updateViews()
    }
    
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        
        title = pokemon.name.capitalized
        pokemonLabel.isHidden = false
        idLabel.isHidden = false
        pokemonTypeLabel.isHidden = false
        abilitiesLabel.isHidden = false
        
        pokemonLabel.text = pokemon.name.capitalized
        idLabel.text = String(pokemon.id)
        
        let pokeTypes = pokemon.types.map { $0.type.name }.joined(separator: ", ")
        pokemonTypeLabel.text = " \(pokeTypes)".capitalized
        
        let pokeAbilitis = pokemon.abilities.map { $0.ability.name }.joined(separator: ", ")
        abilitiesLabel.text = " \(pokeAbilitis)".capitalized
        
    }
    
    func fetchImage() {
        apiController.fetchImage(at: pokemon!.sprites.imageURL, completion: { result in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.pokemonImageView.image = image
                }
            }
        })
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if let pokemon = pokemon,
            let pokemonName = searchBar.text,
            !pokemonName.isEmpty, !apiController.pokeList.contains(pokemon) {
            apiController.pokeList.append(pokemon)
            apiController.saveToPersistentStore()
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
}

extension PokeSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
        print("Search bar clicked")
        saveButton.isHidden = false
        apiController.fetchPokemon(for: searchTerm) { (result) in
            
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                    self.fetchImage()
                }
            } catch {
                print("\(error)")
                return
            }

        }
    }
}
