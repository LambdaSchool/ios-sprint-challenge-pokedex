//
//  SearchPokemonViewController.swift
//  pokedexSprintChallenge
//
//  Created by admin on 9/6/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class SearchPokemonViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var pokedexSearchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController = PokemonController()
    
    var pokemon: Pokemon?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pokedexSearchBar.delegate = self
        
    }
    
    func SearchBarSerachButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchPokemon = searchBar.text?.lowercased(), searchBar.text != "" else { return }
        
        pokemonController.performSearch(with: searchPokemon, completion: { (result) in
            do {
                
                let pokemon = try result.get()
                self.pokemon = pokemon
                
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                }
                
            } catch {
                
                NSLog("Error searching for pokemon: \(error)")
                return
                
            }
        })
    }
        
        func updateViews(with pokemon: Pokemon?) {
            guard let pokemon = pokemon else { return }
            nameLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
            let pokemonTypes: [String] = pokemon.types.map{ $0.type.name}
            typeLabel.text = "\(pokemonTypes.joined(separator: ", "))"
            let pokemonAbilities: [String] = pokemon.abilities.map { $0.ability.name}
            abilitiesLabel.text = "\(pokemonAbilities.joined(separator: ", "))"
            guard let url = URL(string: pokemon.image.frontDefault),
                let images = try? Data(contentsOf: url) else { return }
            pokemonImageView.image = UIImage(data: images)
        }
        
        func savePokemonButtonPressed(_ sender: Any) {
            guard let pokemon = pokemon else { return }
            pokemonController.pokemon.append(pokemon)
            navigationController?.popViewController(animated: true)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


