//
//  SearchPokemonViewController.swift
//  Pokedex
//
//  Created by Christopher Aronson on 5/10/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class SearchPokemonViewController: UIViewController, UISearchBarDelegate {
    var pokemonController: PokemonController?
    var pokemon: Pokemon?

    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonSearchBar.delegate = self
        
        if let selectedPokemon = pokemon {
            updateView(with: selectedPokemon)
            
            guard let pokeController = pokemonController else { return }
            
            pokeController.getImage(at: selectedPokemon.sprites.frontDefault) { result in
                do {
                    let image = try result.get()
                    DispatchQueue.main.async {
                        self.pokemonImageView.image = image
                    }
                } catch {
                    print("Could not load image")
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = pokemonSearchBar.text?.lowercased() else { return }
        guard let pokeController = pokemonController else { return }
        
        pokeController.search(for: text) { (result) in
            do {
                let thisPokemon = try result.get()
                DispatchQueue.main.async {
                    self.updateView(with: thisPokemon)
                }
                pokeController.getImage(at: thisPokemon.sprites.frontDefault, completion: { result in
                    do {
                        let image = try result.get()
                        DispatchQueue.main.async {
                            self.pokemonImageView.image = image
                        }
                    } catch {
                        print("Could not load image")
                    }
                })
                
                self.pokemon = thisPokemon
            }
            catch {
                print(error)
            }
        }
        
    }
    
    func updateView(with pokemnoSearchedFor: Pokemon) {
        pokemonNameLabel.text = pokemnoSearchedFor.name
        pokemonIDLabel.text = String(pokemnoSearchedFor.id)
        pokemonTypesLabel.text = pokemnoSearchedFor.types[0].type.name
        pokemonAbilitiesLabel.text = pokemnoSearchedFor.abilities[0].ability.name
    }

    @IBAction func savePokemonButtonTapped(_ sender: Any) {
        guard let pokemonToSave = pokemon else { return }
        guard let pokeController = pokemonController else { return }
        
        pokeController.save(a: pokemonToSave)
        
        navigationController?.popViewController(animated: true)
    }
}
