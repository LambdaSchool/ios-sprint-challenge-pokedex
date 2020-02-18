//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Zack Larsen on 12/6/19.
//  Copyright © 2019 Zack Larsen. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var IdLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        
        updateViews()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchResult = searchBar.text?.lowercased() else {
            
            print("You didn't enter a Pokemon.")
            return
            
        }
        print("search \(searchResult)")
        pokemonController?.fetchDetails(for: searchResult, completion: { (result) in
            
            guard let pokemon = try? result.get() else {
                print("Did not find a pokemon")
                return
            }
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
            
        })
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemon = pokemon else { return }
        
        title = pokemon.name.capitalized
        displayName.text = pokemon.name.capitalized
        IdLabel.text = String(pokemon.id)
        
        let typeString = pokemon.types.map({ $0.type.name }).joined(separator: ", ")
        typesLabel.text = "Types: \(typeString)"
        
        let abilityString = pokemon.abilities.map( {$0.ability.name}).joined(separator: ", ")
        abilitiesLabel.text = "Abilities: \(abilityString)"
        //        pokemonImage.
        pokemonController?.fetchImage(at: pokemon.sprites.frontDefault, completion: { (image) in
            DispatchQueue.main.async {
                 self.pokemonImage.image = image
            }
           
        })
        let image = UIImage(named: pokemon.sprites.frontDefault)
        pokemonImage.image = image
        
    }
    
    // Do any additional setup after loading the view.
    
    @IBAction func savePokemonTapped(_ sender: UIButton) {
        
        // unwrap pokemon
        guard let pokemon = pokemon else { return }
        pokemonController?.addPokemon(pokemon: pokemon)
           DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
}

