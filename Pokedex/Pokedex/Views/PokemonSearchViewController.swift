//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Joel Groomer on 9/14/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var lblPokemonName: UILabel!
    @IBOutlet weak var lblTypes: UILabel!
    @IBOutlet weak var txtvAbilities: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    
    var pokeController: PokeController?
    var selectedPokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        btnSave.isEnabled = false
        
    }
    
    func updateSelectedPokemonViews(with pokemon: Pokemon?) {
        // if there's a pokemon, uses it. if not, clears and displays a 'not found' message instead
        
        if let pokemon = pokemon {
            lblPokemonName.text = "#\(pokemon.id): \(pokemon.name)"
            pokeController?.getImage(for: pokemon) { (data) in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.imgPokemon.image = UIImage(data: data)
                }
            }
            
            var monsterTypes = ""
            for t in pokemon.types {
                monsterTypes += t.type.name + ", "
            }
            lblTypes.text = monsterTypes
            
            var abilities = ""
            for a in pokemon.abilities {
                abilities += a.ability.name + ", "
            }
            txtvAbilities.text = abilities
            
            btnSave.isEnabled = true
        } else {
            imgPokemon.image = UIImage(named: "nopokemon")
            lblPokemonName.text = "Pokémon not found"
            lblTypes.text = ""
            txtvAbilities.text = ""
            btnSave.isEnabled = false
        }
    }
    
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let pokeController = pokeController, let selectedPokemon = selectedPokemon else { return }
        
        pokeController.addToEncountered(selectedPokemon)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokeController = pokeController,
            let text = searchBar.text,
            !text.isEmpty
        else { return }
        
        searchBar.resignFirstResponder()
        
        pokeController.fetchPokemon(name: text) { (res) in
            do {
                let pokemon = try res.get()
                DispatchQueue.main.async {
                    self.selectedPokemon = pokemon
                    self.updateSelectedPokemonViews(with: pokemon)
                }
            } catch let error as PokeError {
                print(error)
                DispatchQueue.main.async {
                    self.updateSelectedPokemonViews(with: nil)
                }
            } catch {
                print(error)
                return
            }
        }
    }
}
