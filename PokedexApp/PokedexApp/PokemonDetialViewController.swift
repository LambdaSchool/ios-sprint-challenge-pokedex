//
//  PokemonDetialViewController.swift
//  PokedexApp
//
//  Created by Lambda_School_Loaner_218 on 12/6/19.
//  Copyright © 2019 Lambda_School_Loaner_218. All rights reserved.
//

import UIKit

class PokemonDetialViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonApiController: PokemonAPIController!
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        hideSearchBarWithSave()
        updateViews()
        print(pokemonApiController.pokemons.count)
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        
        pokemonApiController?.save(pokemon: pokemon)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func hideSearchBarWithSave() {
        if pokemon != nil {
            saveButton.isHidden = true
            searchBar.isHidden = true
        }
    }
        func hideLabels() {
            if pokemon != nil {
                pokeImageView.isHidden = false
                nameLabel.isHidden = false
                idLabel.isHidden = false
                typeLabel.isHidden = false
                abilityLabel.isHidden = false
            }
        
            if pokemon == nil {
                pokeImageView.isHidden = true
                nameLabel.isHidden = true
                idLabel.isHidden = true
                typeLabel.isHidden = true
                abilityLabel.isHidden = true
            }
    }
            
            
        
        func updateViews() {
            hideLabels()
            guard let myPokemon = pokemon else {print("I RETURNED"); return }
            print(myPokemon.name)
            pokemonApiController?.fetchPokemonImage(at: myPokemon.sprites.frontDefault, completion: { (result) in
                if let image = try? result.get() {
                    print("\(self.pokemon?.name)")
                    self.pokeImageView.image = image
                }
                self.nameLabel.text = myPokemon.name.capitalized
                
                var typeString = " "
                for type in myPokemon.types {
                    typeString += type.type.name
                }
                self.typeLabel.text = "Type: \(typeString)"
                
                var abilities = ""
                for ability in myPokemon.abilities {
                    abilities += ability.ability.name + "  "
                }
                self.abilityLabel.text = abilities
                
                self.idLabel.text = "\(myPokemon.id)"
            })
        }
        
        //}
    }

extension PokemonDetialViewController: UISearchBarDelegate {
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchedPokemon = searchBar.text, !searchedPokemon.isEmpty else {return}
            pokemonApiController?.findPokemon(for: searchedPokemon, completion: { (result) in
                let pokemon = try? result.get()
                print(pokemon?.name)
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                    
                }
            })
       
 }
}

