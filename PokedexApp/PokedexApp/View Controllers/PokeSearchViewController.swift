//
//  PokeSearchViewController.swift
//  PokedexApp
//
//  Created by Nelson Gonzalez on 1/24/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class PokeSearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var idPlaceholderLabel: UILabel!
    
    @IBOutlet weak var typePlaceholderLabel: UILabel!
    
    @IBOutlet weak var abilitiesPlaceholderLabel: UILabel!
    
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
            
        }
    }
  //  var pokemonController =  PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()

        pokeSearchBar.delegate = self
        updateViews()
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = pokeSearchBar.text, !searchTerm.isEmpty else {return}
        PokemonController.shared.searchPokemon(with: searchTerm, completion: { (pokemon, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            self.pokemon = pokemon
            DispatchQueue.main.async {
                self.updateViews()
                self.pokeSearchBar.text = ""
                self.saveButton.isHidden = false
            }
        })
    }
    
    func updateViews() {
        guard let pokemon = pokemon else {
            title = "Pokemon Search"
            pokeSearchBar.isHidden = false
            saveButton.isHidden = true
            nameLabel.isHidden = true
            idLabel.isHidden = true
            typeLabel.isHidden = true
            abilitiesLabel.isHidden = true
            idPlaceholderLabel.isHidden = true
            typePlaceholderLabel.isHidden = true
            abilitiesPlaceholderLabel.isHidden = true
            return
            
        }
        guard let url = URL(string: pokemon.sprites.frontDefault), let imageData = try? Data(contentsOf: url) else {return}
        pokeSearchBar.isHidden = true
        saveButton.isHidden = true
        nameLabel.isHidden = false
        idLabel.isHidden = false
        typeLabel.isHidden = false
        abilitiesLabel.isHidden = false
        idPlaceholderLabel.isHidden = false
        typePlaceholderLabel.isHidden = false
        abilitiesPlaceholderLabel.isHidden = false
        title = pokemon.name
        nameLabel.text = pokemon.name
        idLabel.text = "\(pokemon.id)"
        let types: [String] = pokemon.types.map{$0.type.name}
        typeLabel.text = "\(types.joined(separator: ", "))"
        let abilities: [String] = pokemon.abilities.map{$0.ability.name}
        abilitiesLabel.text = "\(abilities.joined(separator: ", "))"
        pokeImageView.image = UIImage(data: imageData)
    }
   
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        guard let pokemon = pokemon else {return}
        PokemonController.shared.addPokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
}
