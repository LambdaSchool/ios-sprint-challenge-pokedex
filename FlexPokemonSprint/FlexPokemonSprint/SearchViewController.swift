//
//  SearchViewController.swift
//  FlexPokemonSprint
//
//  Created by admin on 10/4/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var iDLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController = PokemonController()
    
    var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    func setViews() {
        guard let pokemon = pokemon else  { return }
            
            nameLabel.isHidden = false
            iDLabel.isHidden = false
            typesLabel.isHidden = false
            abilitiesLabel.isHidden = false
//            id.isHidden = false
//            types.isHidden = false
//            abilities.isHidden = false
            

            
            iDLabel.text = String(pokemon.id)
            nameLabel.text = pokemon.name
            
            var types = ""
            let typeArray = pokemon.types
            
            for type in typeArray {
                types.append("\(type.type.name)")
                types.append("\n")
            }
            
            typesLabel.text = types
            
            var abilities = ""
            let abilityArray = pokemon.abilities
            
            for ability in abilityArray {
                abilities.append("\(ability.ability.name)")
                abilities.append("\n")
            }
            abilitiesLabel.text = abilities
            
            let url = URL(string: pokemon.sprites.frontDefault)!
            if let image = try? Data(contentsOf: url) {
                imageView.image = UIImage(data: image)
            }
        }

        
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        pokemonController.performSearch(with: searchTerm) {
            DispatchQueue.main.async {
                self.setViews()
            }
        }
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        guard let pokemon = pokemon else { return }
        
        pokemonController.createPokemon(name: pokemon.name, sprites: pokemon.sprites, types: pokemon.types, abilities: pokemon.abilities, id: pokemon.id)
        pokemonController.saveToPersistentStore()
        navigationController?.popViewController(animated: true)
    }
    

}
