//
//  PokemonDetailViewController.swift
//  PokedexSprint
//
//  Created by Lambda_School_Loaner_241 on 3/27/20.
//  Copyright © 2020 Lambda_School_Loaner_241. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var savePokemonButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonSearchBar.delegate = self
        

        updateViews()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchPhrase = searchBar.text else { return }
        
        pokemonController?.getPokemenWith(searchWord: searchPhrase, completion: { (result) in
            guard let pokemon = try? result.get() else { return } // result type hover
            
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.savePokemonButton.isHidden = false
            }
        })
    }
    
    @IBAction func savePokemonButtonTapped(_ sender: Any) {
        
        guard let pokemon = pokemon else { return }
        
        pokemonController?.addPokemon(pkmn: pokemon)
    }
    
    
    
    private func updateViews(){
        guard isViewLoaded else { return }
        
        guard let pokemon = pokemon else {
            
            title = " Pokemon Search "
            nameLabel.text = ""
            idLabel.text = ""
            abilitiesLabel.text = ""
            typeLabel.text = ""

            
            return
        }
        
        title = pokemon.name.capitalized
        
        nameLabel.text = pokemon.name.capitalized
        
        idLabel.text = " ID: \(pokemon.id)"
        abilitiesLabel.text = "Abilities: " + pokemon.abilities.map({$0.ability.name}).joined(separator: ", ")
        
        typeLabel.text = "Types: " + pokemon.types.map({$0.type.name}).joined(separator: ", ")
        
        
        self.pokemonController?.getPokemonImage(at: pokemon.sprites.frontDefault, completion: { (image) in
            DispatchQueue.main.async {
                self.pokemonImageView.image = image
            }
        })
    }
    
    

}
