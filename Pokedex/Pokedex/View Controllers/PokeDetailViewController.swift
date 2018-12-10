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
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
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
        self.updateViews()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        searchBar.text = ""
        
        Model.shared.search(for: searchTerm.lowercased())
        
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        navigationItem.title = pokemon.name
        nameLabel.text = pokemon.name
        idLabel.text = "Id: \(pokemon.id)"
        //typesLabel.text = "Types: \(pokemon.types[0])"
        //abilitiesLabel.text = "Abilities: \(pokemon.abilities[0])"
        
        let abilities = pokemon.abilities.map { $0.ability.name }
        abilitiesLabel.text = "Abilities: \(abilities), "
        
        let types = pokemon.types.map {$0.type.name}
        typesLabel.text = "Types: \(types), "
    }
    
    
    
}
