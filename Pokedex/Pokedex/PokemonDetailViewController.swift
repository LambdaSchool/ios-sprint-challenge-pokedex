//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Julian A. Fordyce on 1/25/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
        nameLabel.text = ""
        idLabel.text = ""
        abilityLabel.text = ""
        typeLabel.text = ""
        saveButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    @IBAction func save(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        PokemonController.shared.savePokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        PokemonController.shared.search(searchTerm.lowercased()) { (pokemon, error) in
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
                let data = try? Data(contentsOf: url) else { return }
            self.navigationItem.title = pokemon.name
            self.idLabel.text = "ID: \(pokemon.name)"
            let types: [String] = pokemon.types.map{$0.type.name}
            self.typeLabel.text = "Types: \(types.joined(separator: ", "))"
            let abilities: [String] = pokemon.abilities.map{$0.ability.name}
            self.abilityLabel.text = "Abilities: \(abilities.joined(separator: ", "))"
            self.imageView.image = UIImage(data: data)
        }
    }

    
    // MARK: - Properties
    var pokemon: Pokemon?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var abilityLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
}
