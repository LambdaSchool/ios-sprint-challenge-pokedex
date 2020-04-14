//
//  PokeDetailViewController.swift
//  Pokedex
//
//  Created by Madison Waters on 12/9/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class PokeDetailViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateViews()
    }
    
    var pokemon: Pokemon?
    var pokedex: [Pokemon] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var spriteImage: UIImageView!
    
    @IBAction func save(_ sender: Any) {
        
        guard let pokemon = pokemon else { return }
        Model.shared.addPokemon(pokemon: pokemon)
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        searchBar.text = ""
        
            Pokedex.searchForPokemon(with: searchTerm.lowercased()) { (pokedex, error) in
                if let error = error {
                    NSLog("Error fetching Pokemon: \(error)")
                    return
                } else {
                    self.pokemon = Model.shared.pokemon
                }
            }
        
            DispatchQueue.main.async {
                self.updateViews()
            }
    }
    
    func updateViews() {
        
        DispatchQueue.main.async {
            guard let pokemon = self.pokemon,
                self.isViewLoaded else { return }
            
            self.navigationItem.title = pokemon.name
            self.nameLabel.text = "Front view of \(pokemon.name.capitalized)"
            self.idLabel.text = "Id: \(pokemon.id)"
            
            let abilities = pokemon.abilities.map { $0.ability.name }
            var abilityString = ""
            for index in abilities { abilityString.append("\(index) ") }
            self.abilitiesLabel.text = "Abilities: \(abilityString) "
            
            let types = pokemon.types.map {$0.type.name}
            var typeString = ""
            for index in types { typeString.append("\(index) ") }
            self.typesLabel.text = "Types: \(typeString) "
            
            let urlToImage = pokemon.sprites.frontDefault
            let imageURL = URL(string: urlToImage)!
            self.spriteImage.load(url: imageURL)
            
        }
    }
}
