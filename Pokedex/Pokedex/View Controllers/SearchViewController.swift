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
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        pokemonController.performSearch(with: searchTerm) { _ in
            DispatchQueue.main.async {
                guard let pokemon = self.pokemonController.pokemonResults.last else { return }
                self.nameLabel.text = pokemon.name
                let types = pokemon.types.map({ $0.type.name })
                self.typeLabel.text = types.joined(separator: ", ")
                self.idLabel.text = String(pokemon.id)
                let abilities = pokemon.abilities.map({ $0.ability.name })
                self.abilitiesLabel.text = abilities.joined(separator: ", ")
                self.saveButton.isHidden = false
                self.imageView.image = UIImage(contentsOfFile: pokemon.sprites.frontDefault)
                
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
