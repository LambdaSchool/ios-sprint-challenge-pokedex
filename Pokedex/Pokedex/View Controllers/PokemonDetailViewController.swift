//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Keri Levesque on 2/14/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    //MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK: Properties
    
    var pokemonController: PokemonController!
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
   
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
   //MARK: Methods
    func getPokemons() {
        guard let pokemon = pokemon else { return }
        
        pokemonController.fetchImage(at: pokemon.sprites!.frontDefault) { result in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    
                }
            }
        }
    }
    func updateViews() {
        guard let pokemon = pokemon else { return }
               guard let imageData = try? Data(contentsOf: URL(string: pokemon.sprites!.frontDefault)!) else { return }
               nameLabel.text = pokemon.name
               idLabel.text = "ID: \(String(describing: pokemon.id!))"
               pokeImage.image = UIImage(data: imageData)
              
               
               var abilities: [String] = []
               var types: [String] = []
               
               for newType in pokemon.types {
                   types.append(newType.type.name)
               }

               for newAbility in pokemon.abilities {
                   abilities.append(newAbility.ability.name)
               }
               
               typesLabel.text = "Type: \(types.last!)"
               abilitiesLabel.text = "Ability: \(abilities.last!)"
    }

    //MARK: Actions
    
    @IBAction func saveButton(_ sender: UIButton) {
    }
    
}
extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
       
        pokemonController.fetchPokemon(for: searchTerm) { result in
            let pokemon = try? result.get()
                            
            DispatchQueue.main.async {
                self.pokemon = pokemon

            }
        }
    }
}
