//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Thomas Cacciatore on 5/17/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    var pokemonController = PokemonController()
    var pokemon: Pokemon?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        nameLabel.text = ""
        typeLabel.text = ""
        idLabel.text = ""
        abilitiesLabel.text = ""
        saveButton.isHidden = true
        
    }
    
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemonController.pokemon else { return }
       pokemonController.pokemonResults.append(pokemon)
        print("\(pokemonController.pokemonResults)")
        
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        pokemonController.performSearch(with: searchTerm) { _ in
            guard let pokemon = self.pokemonController.pokemon else { return }
            DispatchQueue.main.async {
                
                self.nameLabel.text = pokemon.name
                let types = pokemon.types.map({ $0.type.name })
                self.typeLabel.text = types.joined(separator: ", ")
                self.idLabel.text = "\(pokemon.id)"
                let abilities = pokemon.abilities.map({ $0.ability.name })
                self.abilitiesLabel.text = abilities.joined(separator: ", ")
                self.saveButton.isHidden = false
//                self.imageView.image = UIImage(contentsOfFile: pokemon?.sprites.frontDefault)
                //IMAGE is not working!!
                
            }
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
}
