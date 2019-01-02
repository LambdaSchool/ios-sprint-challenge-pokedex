//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Julian A. Fordyce on 1/1/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    var pokemon: Pokemon?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
        pokemonNameLabel.text = ""
        idLabel.text = ""
        abilitiesLabel.text = ""
        typesLabel.text = ""
        saveButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    @IBAction func save(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        PokemonModel.shared.savePokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        PokemonModel.shared.search(with: searchTerm.lowercased()) { (pokemon, error) in
            if let pokemon = pokemon, error == nil {
                self.pokemon = pokemon
                DispatchQueue.main.async {
                    self.updateViews()
                    searchBar.text = ""
                    self.saveButton.isHidden = false
                }
            }
        }
    }
    
    func updateViews() {
        DispatchQueue.main.async {
            guard let pokemon = self.pokemon else { return }
            guard let url = URL(string: pokemon.sprites.frontDefault),
                let imageData = try? Data(contentsOf: url) else { return }
            self.navigationItem.title = pokemon.name
            self.pokemonNameLabel.text = pokemon.name
            self.idLabel.text = "ID: \(pokemon.id)"
            let types: [String] = pokemon.types.map{$0.type.name}
            self.typesLabel.text = "Types: \(types.joined(separator: ", "))"
            let abilities: [String] = pokemon.abilities.map{$0.ability.name}
            self.abilitiesLabel.text = "Abilities: \(abilities.joined(separator: ", "))"
            self.imageView.image = UIImage(data: imageData)
        }
    }
}
